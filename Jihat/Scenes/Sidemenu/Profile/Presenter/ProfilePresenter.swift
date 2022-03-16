//
//  ProfilePresenter.swift
//  Jihat
//
//  Created Ahmed Barghash on 25/09/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

// MARK: Profile Presenter -

class ProfilePresenter: BasePresenter {

    weak var view: ProfileViewProtocol?
    private let interactor: ProfileInteractorInputProtocol
    private let router: ProfileRouterProtocol
    
    private var nationalities: [CountriesModel] = []
    private var resident: String?
    private var nationality: String?
    private var arabicName: String?
    private var englishName: String?
    private var gender: String?
    private var flagCode: String?
    private var mobile: String?
    private var email: String?
    private var id: String?
    private var address: String?
    private var fax: String?
    
    private var countryId: String!
    private var eGender: Gender!
    
    private var newNationality: String?
    private var newArabicName: String?
    private var newEnglishName: String?
    private var newGender: String?
    private var newPhone: String?
    private var newEmail: String?
    private var newId: String?
    private var newAddress: String?
    private var newFax: String?
    
    private var updateProfileCompletion: UpdateProfileCompletion
    
    init(view: ProfileViewProtocol, interactor: ProfileInteractorInputProtocol, router: ProfileRouterProtocol, updateProfileCompletion: UpdateProfileCompletion = nil) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.updateProfileCompletion = updateProfileCompletion
    }
}

// MARK: - ProfilePresenterProtocol
extension ProfilePresenter: ProfilePresenterProtocol {
    
    func viewDidLoad() {
        view?.showLoading()
        interactor.getProfileData(profileRequest: BaseRequest(userToken: interactor.userToken))
    }
    
    func performObserveInputs(nationality: String?, gender: String?, arabicName: String?, englishName: String?, mobile: String?, mobileIsValid: Bool, email: String?, id: String?, address: String?, fax: String?) {
        
        /*
         1. Check arabic name, english name, mobile is valid, email is valid and id is not empty.
         2. In success: check for changes.
         3. In Fail: return false.
         */
        
        var observeInputs: Bool
        if arabicName?.isEmpty == false && englishName?.isEmpty == false && mobileIsValid && email?.isValidEmail() == true && id?.isEmpty == false {
            observeInputs = (nationality?.isEmpty == false && self.nationality?.removeLeadingAndTrailingSpaces() != nationality?.removeLeadingAndTrailingSpaces()) || (arabicName?.isEmpty == false && self.arabicName?.removeLeadingAndTrailingSpaces() != arabicName?.removeLeadingAndTrailingSpaces()) || (englishName?.isEmpty == false && self.englishName?.removeLeadingAndTrailingSpaces() != englishName?.removeLeadingAndTrailingSpaces()) || (gender?.isEmpty == false && self.gender?.removeLeadingAndTrailingSpaces() != gender?.removeLeadingAndTrailingSpaces()) || (mobile?.isEmpty == false && (self.mobile?.removeLeadingAndTrailingSpaces() != mobile?.removeLeadingAndTrailingSpaces()) && mobileIsValid) || (email?.isEmpty == false && self.email?.removeLeadingAndTrailingSpaces() != email?.removeLeadingAndTrailingSpaces() && email?.isValidEmail() == true) || (id?.isEmpty == false &&  self.id?.removeLeadingAndTrailingSpaces() != id?.removeLeadingAndTrailingSpaces()) || (address?.isEmpty == false && self.address?.removeLeadingAndTrailingSpaces() != address?.removeLeadingAndTrailingSpaces()) || (fax?.isEmpty == false && self.fax?.removeLeadingAndTrailingSpaces() != fax?.removeLeadingAndTrailingSpaces())
        } else {
            observeInputs = false
        }
        observeInputs ? view?.enableSaveChangesButton() : view?.disableSaveChangesButton()
    }
    
}

// MARK: - API
extension ProfilePresenter: ProfileInteractorOutputProtocol {
    
    func fetchingUserWithSuccess(user: UserDataResponse) {
        
        nationality = user.nationality
        arabicName = user.arabicName
        englishName = user.englishName
        gender = user.gender
        flagCode = user.countryId
        mobile = user.phone
        email = user.email
        id = user.identificiationNumber
        address = LocalizationHelper.isArabic() ? user.arabicAddress : user.englishAddress
        fax = user.fax
        
        countryId = user.country == "0" ? "0" : user.countryId
        eGender = Gender(rawValue: user.genderId?.toInt() ?? 0)
        
        view?.setResident(user.country == "0" ? "inside_country".localized() : "outside_country".localized())
        view?.setNationality(user.nationality ?? "")
        view?.setArabicName(user.arabicName ?? "")
        view?.setEnglishName(user.englishName ?? "")
        view?.setGender(user.gender ?? "")
        view?.setPhoneFlag(user.countryId ?? "")
        view?.setPhoneNumber(user.phone ?? "")
        view?.setEmail(user.email ?? "")
        view?.setUserId(user.identificiationNumber)
        view?.setUserAddress(LocalizationHelper.isArabic() ? (user.arabicAddress ?? "") : (user.englishAddress ?? ""))
        view?.setUserFax(user.fax ?? "")
    }
    
    func fetchingCountriesSuccessfully(countries: [CountriesModel]) {
        self.nationalities = countries
        view?.refreshNationalitiesPickerView()
        let index = nationalities.firstIndex(where: { $0.id == countryId }) ?? 0
        print(index)
        view?.selectNationalityInPicker(atIndex: index)
    }
    
    func hideSuccessLoading() {
        view?.hideLoading()
    }
    
    func fetchingUpdateUserDataWithsuccess(message: String) {
        view?.stopLoadingOnSaveChangesButton()
        let user = UserDataResponse(id: interactor.userId, englishName: newEnglishName, arabicName: newArabicName, phone: newPhone, email: newEmail, identificiationNumber: newId, arabicAddress: newAddress, englishAddress: newAddress, fax: newFax, gender: newGender, genderId: eGender.rawValue.toString(), nationality: newNationality, country: nil, countryId: nationalities.first(where: { $0.id == newNationality })?.id)
        updateProfileCompletion?(user)
        view?.showBottomMessage(message)
        router.popupViewController()
    }
    
    func fetchingWithError(error: String) {
        view?.hideLoading()
        view?.stopLoadingOnSaveChangesButton()
        view?.showBottomMessage(error)
    }
}

// MARK: - Selectors
extension ProfilePresenter {
    
    func showNationality() {
        view?.enableEditNationality()
    }
    
    func hideNationality() {
        view?.disableEditNationality()
    }
    
    func performEditArabicName() {
        view?.enableEditArabicNameTextField()
    }
    
    func performEditEnglishName() {
        view?.enableEditEnglishNameTextField()
    }
    
    func performShowCountriesList() {
        router.showCountriesList()
    }
    
    func showGender() {
        view?.enableEditGender()
    }
    
    func hideGender() {
        view?.disableEditGender()
    }
    
    func performEditMobile() {
        view?.enableEditMobileTextField()
    }
    
    func performEditEmail() {
        view?.enableEditEmailTextField()
    }
    
    func performEditIdNumber() {
        view?.enableEditIdNumberTextField()
    }
    
    func performEditAddress() {
        view?.enableEditAddressTextField()
    }
    
    func performEditFax() {
        view?.enableEditFaxTextField()
    }
    
    func performSaveChanges(arabicName: String?, englishName: String?, phone: String?, email: String?, identificationCard: String?, address: String?, fax: String?) {
        let updateUserDataRequest = UpdateUserDataRequest(userToken: interactor.userToken, englishName: englishName?.removeLeadingAndTrailingSpaces(), arabicName: arabicName?.removeLeadingAndTrailingSpaces(), phone: phone, email: email?.removeLeadingAndTrailingSpaces(), identificiationNumber: identificationCard?.arToEnDigits, arabicAddress: address?.removeLeadingAndTrailingSpaces(), englishAddress: address?.removeLeadingAndTrailingSpaces(), fax: fax?.arToEnDigits, genderId: eGender.rawValue.toString(), countryId: countryId)
        view?.startLoadingOnSaveChangesButton()
        newNationality = nationalities.first(where: { $0.id == nationality })?.name
        newArabicName = arabicName
        newEnglishName = englishName
        newGender = eGender.description
        newPhone = phone
        newEmail = email
        newId = identificationCard
        newAddress = address
        newFax = fax
        interactor.updateUserData(updateUserDataRequest: updateUserDataRequest)
    }
    
    func performDiscardChanges() {
        router.popupViewController()
    }
    
}

// MARK: - NationalitiesPickerView Setup
extension ProfilePresenter {
    
    var nationalitiesCount: Int {
        return nationalities.count
    }
    
    func configureNatiolaitiesRow(atIndex index: Int) -> String {
        return nationalities[index].name ?? ""
    }
    
    func didselectNationality(atIndex index: Int) {
        countryId = nationalities[index].id
        view?.set(nationality: nationalities[index].name ?? "")
        view?.disableEditNationality()
    }
}

// MARK: - GendersPickerView Setup
extension ProfilePresenter {
    
    var gendersCount: Int {
        return Gender.allCases.count
    }
    
    func configureGendersRow(atIndex index: Int) -> String {
        return Gender.allCases[index].description.localized()
    }
    
    func didSelectGender(atIndex index: Int) {
        eGender = Gender.allCases[index]
        view?.setSelectedGender(gender: Gender.allCases[index].description.localized())
        view?.disableEditGender()
    }
    
}
