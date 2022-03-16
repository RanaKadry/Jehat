//
//  ForgetPasswordProtocols.swift
//  Jihat
//
//  Created Peter Bassem on 26/10/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

// MARK: ForgetPassword Protocols

protocol ForgetPasswordViewProtocol: BaseViewProtocol {
    var presenter: ForgetPasswordPresenterProtocol! { get set }
    
    func enableResetPasswordButton()
    func disableResetPasswordButton()
    func startLoadingOnResetPasswordButton()
    func stopLoadingOnResetPasswordButton()
}

protocol ForgetPasswordPresenterProtocol: BasePresenterProtocol {
    var view: ForgetPasswordViewProtocol? { get set }
    
    func viewDidLoad()
    
    func performValidation(_ email: String?)

    func performBack()
    func performResetPassword(email: String?)
}

protocol ForgetPasswordRouterProtocol: BaseRouterProtocol {
    
}

protocol ForgetPasswordInteractorInputProtocol: BaseInteractorInputProtocol {
    var presenter: ForgetPasswordInteractorOutputProtocol? { get set }
 
    func resetPassword(forgetPasswordRequest: ForgetPasswordRequest)
}

protocol ForgetPasswordInteractorOutputProtocol: BaseInteractorOutputProtocol {
    func fetchingResetPasswordWithSucess(message: String)
    func fetchingWithError(_ error: String)
}
