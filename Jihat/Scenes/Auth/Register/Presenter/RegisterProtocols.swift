//
//  RegisterProtocols.swift
//  Jihat
//
//  Created Peter Bassem on 17/09/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

// MARK: Register Protocols

protocol RegisterViewProtocol: BaseViewProtocol {
    var presenter: RegisterPresenterProtocol! { get set }
    
    func refreshAppBarCollectionView()
    func hideCountry()
    func showCountry()
    func hidePhone()
    func showPhone()
    func refreshCountriesPickerView()
    func displaySelectedGender(_ gender: String)
    func displaySelectedContry(_ country: String)
    func enableCreateNewAccountButton()
    func disableCreateNewAccountButton()
    func startLoadingOnCreateNewAccountButton()
    func stopLoadingOnCreateNewAccountButton()
}

protocol RegisterPresenterProtocol: BasePresenterProtocol {
    var view: RegisterViewProtocol? { get set }
    
    func viewDidLoad()
    
    func performValidation(arabicFullname: String?, englishFullname: String?, identity: String?, password: String?, mobileValid: Bool, email: String?)

    var itemsCount: Int { get }
    func configureNavigationBarCellItem(_ cell: AppNavigationItemCollectionViewCellProtocol, atIndex index: Int)
    func didSelectNavigationBarCellItem(atIndex index: Int)
    
    var gendersCount: Int { get }
    func setGender(atIndex index: Int) -> String
    func didSelectGender(atIndex index: Int)
    
//    var countriesCount: Int { get }
//    func setCountry(atIndex index: Int) -> String?
//    func didSelectCountry(atIndex index: Int)
    
    func performBack()
    func performShowNationalities()
    func performIdentityInformation()
    func performShowCountriesList()
    func performRegister(arabicName: String?, englishName: String?, identity: String?, password: String?, phone: String?, email: String?)
}

protocol RegisterRouterProtocol: BaseRouterProtocol {
    func presentNationalitiesViewController(countries: [CountriesModel], searchItemSelection: @escaping SearchItemSelection<CountriesModel>)
    func navigateToPhoneVerificationViewController()
}

protocol RegisterInteractorInputProtocol: BaseInteractorInputProtocol {
    var presenter: RegisterInteractorOutputProtocol? { get set }
    
    func getUserCountries()
    func registerUser(registerRequest: RegisterRequest)
    func saveUser(id: String?)
    func update(userVerified: Bool)
}

protocol RegisterInteractorOutputProtocol: BaseInteractorOutputProtocol {
    func fetchingCountriesSuccessfully(countries: [CountriesModel])
    func fetchingRegisterUserMessageSuccessfully(successMessage: String)
    func fetchingRegisterUserSuccessfully(registerResponse: AuthModel)
    func fetchingWithError(error: String)
}
