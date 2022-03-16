//
//  RegisterPresenter.swift
//  Jihat
//
//  Created Peter Bassem on 17/09/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

// MARK: Register Presenter -

class RegisterPresenter: BasePresenter {

    weak var view: RegisterViewProtocol?
    private let interactor: RegisterInteractorInputProtocol
    private let router: RegisterRouterProtocol
    
    private var registerType: RegisterTypes?
    
    private var countries: [CountriesModel] = []
    private var selectedCountryId: String?
    private var countrySelected = false
    
    private var selectedGender: Int?
    private var genderSelected = false
    
    init(view: RegisterViewProtocol, interactor: RegisterInteractorInputProtocol, router: RegisterRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

// MARK: - RegisterPresenterProtocol
extension RegisterPresenter: RegisterPresenterProtocol {
    
    func viewDidLoad() {
        view?.refreshAppBarCollectionView()
        interactor.getUserCountries()
    }

    func performValidation(arabicFullname: String?, englishFullname: String?, identity: String?, password: String?, mobileValid: Bool, email: String?) {
//        let validateInputs = arabicFullname?.isEmpty == false && englishFullname?.isEmpty == false && genderSelected && countrySelected && identity?.isEmpty == false && password?.isEmpty == false && (password?.count ?? 0) >= 6 && mobileValid && email?.isEmpty == false && email?.isValidEmail() == true
        
        let validateInputs = arabicFullname?.isEmpty == false && englishFullname?.isEmpty == false && identity?.isEmpty == false && (identity?.count ?? 0) >= 8 && password?.isEmpty == false && (password?.count ?? 0) >= 6 && mobileValid && email?.isEmpty == false && email?.isValidEmail() == true
        validateInputs ? view?.enableCreateNewAccountButton() : view?.disableCreateNewAccountButton()
    }
}

// MARK: - API
extension RegisterPresenter: RegisterInteractorOutputProtocol {
    
    func fetchingCountriesSuccessfully(countries: [CountriesModel]) {
        self.countries = countries
        view?.refreshCountriesPickerView()
    }
    
    func fetchingRegisterUserMessageSuccessfully(successMessage: String) {
        view?.showBottomMessage(successMessage)
    }
    
    func fetchingRegisterUserSuccessfully(registerResponse: AuthModel) {
        view?.stopLoadingOnCreateNewAccountButton()
        interactor.saveUser(id: registerResponse.id)
        interactor.update(userVerified: true)
        router.navigateToPhoneVerificationViewController()
    }
    
    func fetchingWithError(error: String) {
        view?.stopLoadingOnCreateNewAccountButton()
        view?.showBottomMessage(error)
    }
}

// MARK: - Selector
extension RegisterPresenter {
    
    func performBack() {
        router.popupViewController()
    }
    
    func performShowNationalities() {
        router.presentNationalitiesViewController(countries: countries) { [unowned self] country in
            self.selectedCountryId = country.id
            self.countrySelected = true
            self.view?.displaySelectedContry(country.name ?? "")
        }
    }
    
    func performIdentityInformation() {
        router.presentAlertControl(title: "info".localized(), message: "id_info".localized(), actionTitle: "ok".localized(), action: nil)
    }
    
    func performShowCountriesList() {
        router.showCountriesList()
    }
    
    func performRegister(arabicName: String?, englishName: String?, identity: String?, password: String?, phone: String?, email: String?) {
        view?.startLoadingOnCreateNewAccountButton()
        let countryId: String? = registerType == .insideCountry ? 0.toString() : (selectedCountryId ?? 0.toString())
        let registerRequest = RegisterRequest(country: countryId, arabicName: arabicName?.removeLeadingAndTrailingSpaces(), englishName: englishName?.removeLeadingAndTrailingSpaces(), mobile: phone?.arToEnDigits ?? phone, email: email, card: identity?.arToEnDigits, password: password?.arToEnDigits, gender: (selectedGender ?? 0).toString())
        interactor.registerUser(registerRequest: registerRequest)
    }
}

// MARK: - NavigationBarCollectionView Setup
extension RegisterPresenter {
    
    var itemsCount: Int {
        return RegisterTypes.allCases.count
    }
    
    func configureNavigationBarCellItem(_ cell: AppNavigationItemCollectionViewCellProtocol, atIndex index: Int) {
        cell.displayItem(title: RegisterTypes.allCases[index].description.localized())
    }
    
    func didSelectNavigationBarCellItem(atIndex index: Int) {
        registerType = RegisterTypes.allCases.first(where: { $0.rawValue == index })
    }
}

// MARK: - GenderPickerView Setup
extension RegisterPresenter {
    
    var gendersCount: Int {
        return Gender.allCases.count
    }
    
    func setGender(atIndex index: Int) -> String {
        return Gender.allCases[index].description.localized()
    }
    
    func didSelectGender(atIndex index: Int) {
        selectedGender = Gender.allCases[index].rawValue
        genderSelected = true
        view?.displaySelectedGender(Gender.allCases[index].description.localized())
    }
}

// MARK: - CountriesPickerView Setup
//extension RegisterPresenter {
//    
//    var countriesCount: Int {
//        return countries.count
//    }
//    
//    func setCountry(atIndex index: Int) -> String? {
//        return countries[index].name
//    }
//    
//    func didSelectCountry(atIndex index: Int) {
//        selectedCountryId = countries[index].id
//        countrySelected = true
//        view?.displaySelectedContry(countries[index].name ?? "")
//    }
//}
