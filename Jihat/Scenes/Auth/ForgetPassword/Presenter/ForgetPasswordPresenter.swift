//
//  ForgetPasswordPresenter.swift
//  Jihat
//
//  Created Peter Bassem on 26/10/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

// MARK: ForgetPassword Presenter -

class ForgetPasswordPresenter: BasePresenter {

    weak var view: ForgetPasswordViewProtocol?
    private let interactor: ForgetPasswordInteractorInputProtocol
    private let router: ForgetPasswordRouterProtocol
    
    init(view: ForgetPasswordViewProtocol, interactor: ForgetPasswordInteractorInputProtocol, router: ForgetPasswordRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
}

// MARK: - ForgetPasswordPresenterProtocol
extension ForgetPasswordPresenter: ForgetPasswordPresenterProtocol {
    
    func viewDidLoad() {
        
    }
    
    func performValidation(_ email: String?) {
        let validateInputs = email?.isEmpty == false && email?.isValidEmail() == true
        validateInputs ? view?.enableResetPasswordButton() : view?.disableResetPasswordButton()
    }
}

// MARK: - API
extension ForgetPasswordPresenter: ForgetPasswordInteractorOutputProtocol {
    
    func fetchingResetPasswordWithSucess(message: String) {
        view?.stopLoadingOnResetPasswordButton()
        view?.showBottomMessage(message)
        router.popupViewController()
    }
    func fetchingWithError(_ error: String) {
        view?.stopLoadingOnResetPasswordButton()
        view?.showBottomMessage(error)
    }
}

// MARK: - Selector
extension ForgetPasswordPresenter {
    
    func performBack() {
        router.popupViewController()
    }
    
    func performResetPassword(email: String?) {
        view?.startLoadingOnResetPasswordButton()
        interactor.resetPassword(forgetPasswordRequest: ForgetPasswordRequest(email: email))
    }
}
