//
//  LoginProtocols.swift
//  Jihat
//
//  Created Peter Bassem on 15/09/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

// MARK: Login Protocols

protocol LoginViewProtocol: BaseViewProtocol {
    var presenter: LoginPresenterProtocol! { get set }
    
    func setLanguageButtonTitle(_ title: String)
    
    func refreshCollectionView()
    
    func enableLoginButton()
    func disableLoginButton()
    func startLoadingOnLoginButton()
    func stopLoadingOnLoginButton()
}

protocol LoginPresenterProtocol: BasePresenterProtocol {
    var view: LoginViewProtocol? { get set }
    
    func viewDidLoad()
    
    var sponsersCount: Int { get }
    func configureSponserCell(_ cell: SponserCollectionViewCellProtocol, atIndex index: Int)
    func didSelectSponser(atIndex index: Int)
    
    func performValidate(withUsername username: String?, password: String?)
    
    func performChangeLanguage()
    func performLoginAsAgent()
    func performLogin(withCard card: String?, password: String?)
    func performForgetPassword()
    func performCreateNewAccount()
    func perfromSkip()
}

protocol LoginRouterProtocol: BaseRouterProtocol {
    func navigateToHomeViewController()
    func navigateToForgetPasswordViewController()
    func navigateToRegisterViewController()
}

protocol LoginInteractorInputProtocol: BaseInteractorInputProtocol {
    var presenter: LoginInteractorOutputProtocol? { get set }
    
    func getSponsers()
    func loginUser(withLoginRequest loginRequest: LoginRequest)
    
    func saveUser(token: String?)
    func saveUser(id: String?)
}

protocol LoginInteractorOutputProtocol: BaseInteractorOutputProtocol {
    func fetchingSponsersSuccessfully(sponsers: [SponsersModel])
    func fetchingLoginSuccessfully(login: AuthModel)
    func fetchingWithError(error: String)
}
