//
//  ProfileProtocols.swift
//  Jihat
//
//  Created Ahmed Barghash on 25/09/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

// MARK: Profile Protocols

protocol ProfileViewProtocol: BaseViewProtocol {
    var presenter: ProfilePresenterProtocol! { get set }
    
    func refreshNationalitiesPickerView()
    func setResident(_ resident: String?)
    func setNationality(_ nationality: String?)
    func selectNationalityInPicker(atIndex index: Int)
    func setArabicName(_ arabicName: String?)
    func setEnglishName(_ englishName: String?)
    func setGender(_ gender: String?)
    func setPhoneFlag(_ flag: String?)
    func setPhoneNumber(_ phone: String?)
    func setEmail(_ email: String?)
    func setUserId(_ id: String?)
    func setUserAddress(_ address: String?)
    func setUserFax(_ fax: String?)
    
    func enableEditNationality()
    func disableEditNationality()
    func set(nationality: String)
    func enableEditArabicNameTextField()
    func enableEditEnglishNameTextField()
    func enableEditGender()
    func disableEditGender()
    func setSelectedGender(gender: String)
    func enableEditMobileTextField()
    func enableEditEmailTextField()
    func enableEditIdNumberTextField()
    func enableEditAddressTextField()
    func enableEditFaxTextField()
    
    func enableSaveChangesButton()
    func disableSaveChangesButton()
    
    func startLoadingOnSaveChangesButton()
    func stopLoadingOnSaveChangesButton()
    
}

protocol ProfilePresenterProtocol: BasePresenterProtocol {
    var view: ProfileViewProtocol? { get set }
    
    func viewDidLoad()
    
    func performObserveInputs(nationality: String?, gender: String?, arabicName: String?, englishName: String?, mobile: String?, mobileIsValid: Bool, email: String?, id: String?, address: String?, fax: String?)
    
    var nationalitiesCount: Int { get }
    func configureNatiolaitiesRow(atIndex index: Int) -> String
    func didselectNationality(atIndex index: Int)
    
    var gendersCount: Int { get }
    func configureGendersRow(atIndex index: Int) -> String
    func didSelectGender(atIndex index: Int)
    
    func showNationality()
    func hideNationality()
    func performEditArabicName()
    func performEditEnglishName()
    func performShowCountriesList()
    func showGender()
    func hideGender()
    func performEditMobile()
    func performEditEmail()
    func performEditIdNumber()
    func performEditAddress()
    func performEditFax()
    func performSaveChanges(arabicName: String?, englishName: String?, phone: String?, email: String?, identificationCard: String?, address: String?, fax: String?)
    func performDiscardChanges()
}

protocol ProfileRouterProtocol: BaseRouterProtocol {
    
}

protocol ProfileInteractorInputProtocol: BaseInteractorInputProtocol {
    var presenter: ProfileInteractorOutputProtocol? { get set }
    
    var userToken: String? { get }
    var userId: String? { get }
    func getProfileData(profileRequest: BaseRequest)
    func updateUserData(updateUserDataRequest: UpdateUserDataRequest)
}

protocol ProfileInteractorOutputProtocol: BaseInteractorOutputProtocol {
    func fetchingUserWithSuccess(user: UserDataResponse)
    func fetchingCountriesSuccessfully(countries: [CountriesModel])
    func hideSuccessLoading()
    func fetchingUpdateUserDataWithsuccess(message: String)
    func fetchingWithError(error: String)
}
