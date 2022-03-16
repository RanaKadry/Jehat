//
//  PhoneVerificationProtocols.swift
//  Jihat
//
//  Created Peter Bassem on 18/09/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

// MARK: PhoneVerification Protocols

protocol PhoneVerificationViewProtocol: BaseViewProtocol {
    var presenter: PhoneVerificationPresenterProtocol! { get set }
    
    func clearOTPCodeTextField()
    func enableSubmitButton()
    func disbaleSubmitButton()
    func startLoadingOnSubmitButton()
    func stopLoadingOnSubmitButton()
}

protocol PhoneVerificationPresenterProtocol: BasePresenterProtocol {
    var view: PhoneVerificationViewProtocol? { get set }
    
    func viewDidLoad()
    func performValidation(isValidCode validCode: Bool)

    func performBack()
    func performResendActivationCode()
    func performSubmit(withCode code: String?)
}

protocol PhoneVerificationRouterProtocol: BaseRouterProtocol {
    func presentRegisterSuccessfullyViewController(alertActionCompletion: @escaping ActionCompletion)
    func navigateToLoginViewController()
}

protocol PhoneVerificationInteractorInputProtocol: BaseInteractorInputProtocol {
    var presenter: PhoneVerificationInteractorOutputProtocol? { get set }
 
    var userId: String? { get }
    var sendSMSAgain: Bool { get }
    func updateSendSMS(_ sendSMS: Bool)
    func resendVerificationCode(resendVerificationCodeRequest: ResendVerifiyCodeRequest)
    func sendVerificationCode(submitVerificationCodeRequest: VerifyCodeRequest)
    func updatedVerificationState(userVerified: Bool)
}

protocol PhoneVerificationInteractorOutputProtocol: BaseInteractorOutputProtocol {
    func fetchingVerificationCode(message: String)
    func fetchingWithMessage(_ message: String)
}
