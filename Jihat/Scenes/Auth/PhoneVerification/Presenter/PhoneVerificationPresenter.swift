//
//  PhoneVerificationPresenter.swift
//  Jihat
//
//  Created Peter Bassem on 18/09/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

// MARK: PhoneVerification Presenter -

class PhoneVerificationPresenter: BasePresenter {

    weak var view: PhoneVerificationViewProtocol?
    private let interactor: PhoneVerificationInteractorInputProtocol
    private let router: PhoneVerificationRouterProtocol
    
    init(view: PhoneVerificationViewProtocol, interactor: PhoneVerificationInteractorInputProtocol, router: PhoneVerificationRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
}

// MARK: - PhoneVerificationPresenterProtocol
extension PhoneVerificationPresenter: PhoneVerificationPresenterProtocol {
    
    func viewDidLoad() {
        if interactor.sendSMSAgain {
            view?.showLoading()
            view?.startLoadingOnSubmitButton()
            interactor.resendVerificationCode(resendVerificationCodeRequest: ResendVerifiyCodeRequest(clientId: interactor.userId))
        }
        interactor.updateSendSMS(true)
    }
    
    func performValidation(isValidCode validCode: Bool) {
        validCode ? view?.enableSubmitButton() : view?.disbaleSubmitButton()
    }
}

// MARK: - API
extension PhoneVerificationPresenter: PhoneVerificationInteractorOutputProtocol {
    
    func fetchingWithMessage(_ message: String) {
        view?.hideLoading()
        view?.clearOTPCodeTextField()
        view?.stopLoadingOnSubmitButton()
        view?.showBottomMessage(message)
    }
    
    func fetchingVerificationCode(message: String) {
        view?.stopLoadingOnSubmitButton()
        view?.showBottomMessage(message)
        interactor.updatedVerificationState(userVerified: false)
        router.presentRegisterSuccessfullyViewController { [weak self] in
            self?.router.navigateToLoginViewController()
        }
    }
}

// MARK: - Selectors
extension PhoneVerificationPresenter {
    
    func performBack() {
        router.popupViewController()
    }
    
    func performResendActivationCode() {
        view?.showLoading()
        interactor.resendVerificationCode(resendVerificationCodeRequest: ResendVerifiyCodeRequest(clientId: interactor.userId))
    }
    
    func performSubmit(withCode code: String?) {
        view?.startLoadingOnSubmitButton()
        interactor.sendVerificationCode(submitVerificationCodeRequest: VerifyCodeRequest(code: code))
    }
}
