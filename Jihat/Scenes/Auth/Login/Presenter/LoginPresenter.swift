//
//  LoginPresenter.swift
//  Jihat
//
//  Created Peter Bassem on 15/09/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

// MARK: Login Presenter -

class LoginPresenter: BasePresenter {

    weak var view: LoginViewProtocol?
    private let interactor: LoginInteractorInputProtocol
    private let router: LoginRouterProtocol
    
    private var sponsers: [SponsersModel] = []
    
    init(view: LoginViewProtocol, interactor: LoginInteractorInputProtocol, router: LoginRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

// MARK : - LoginPresenterProtocol
extension LoginPresenter: LoginPresenterProtocol {
    
    func viewDidLoad() {
        view?.setLanguageButtonTitle(LocalizationHelper.isArabic() ? "language.english".localized() : "language.arabic".localized())
        interactor.getSponsers()
    }
    
    func performValidate(withUsername username: String?, password: String?) {
        let validateInputs = username?.isEmpty == false && (username?.count ?? 0) >= 8 && password?.isEmpty == false && (password?.count ?? 0) >= 6
        validateInputs ? view?.enableLoginButton() : view?.disableLoginButton()
    }
}

// MARK : - API
extension LoginPresenter: LoginInteractorOutputProtocol {
    
    func fetchingSponsersSuccessfully(sponsers: [SponsersModel]) {
        self.sponsers = sponsers
        view?.refreshCollectionView()
    }
    
    func fetchingLoginSuccessfully(login: AuthModel) {
        interactor.saveUser(token: login.token)
        interactor.saveUser(id: login.id)
        view?.stopLoadingOnLoginButton()
        router.navigateToHomeViewController()
    }
    
    func fetchingWithError(error: String) {
        view?.stopLoadingOnLoginButton()
        view?.showBottomMessage(error)
    }
}

// MARK : - Selectors
extension LoginPresenter {
    
    func performChangeLanguage() {
        switch LocalizationHelper.getCurrentLanguage() {
        case "en":
            guard LocalizationHelper.getCurrentLanguage() == "en" else {
                print("Same Language")
                return
            }
            LocalizationHelper.setCurrentLang(lang: "ar")
            IQKeyboardManagerHelper.setDoneTitle()
        case "ar":
            guard LocalizationHelper.getCurrentLanguage() == "ar" else {
                print("Same Language")
                return
            }
            LocalizationHelper.setCurrentLang(lang: "en")
            IQKeyboardManagerHelper.setDoneTitle()
        default: break
        }
    }
    
    func performLoginAsAgent() {
        router.openBrowser(fromUrl: GlobalConstants.loginAsAgentUrl.rawValue)
    }
    
    func performLogin(withCard card: String?, password: String?) {
        view?.startLoadingOnLoginButton()
        let loginRequest = LoginRequest(id: card?.arToEnDigits, password: password?.arToEnDigits)
        interactor.loginUser(withLoginRequest: loginRequest)
    }
    
    func performForgetPassword() {
        router.navigateToForgetPasswordViewController()
    }
    
    func performCreateNewAccount() {
        router.navigateToRegisterViewController()
    }
    
    func perfromSkip() {
//        router.navigateToGuestViewController()
        router.navigateToHomeViewController()
    }
}

// MARK : - SponsersCollectionView Setup
extension LoginPresenter {
    
    var sponsersCount: Int {
        return sponsers.count
    }
    
    func configureSponserCell(_ cell: SponserCollectionViewCellProtocol, atIndex index: Int) {
        cell.set(sponser: sponsers[index].name ?? "")
    }
    
    func didSelectSponser(atIndex index: Int) {
        router.openBrowser(fromUrl: sponsers[index].id ?? "")
    }
}
