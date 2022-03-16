//
//  ForgetPasswordInteractor.swift
//  Jihat
//
//  Created Peter Bassem on 26/10/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

// MARK: ForgetPassword Interactor -

class ForgetPasswordInteractor: ForgetPasswordInteractorInputProtocol {
    
    weak var presenter: ForgetPasswordInteractorOutputProtocol?
    private let useCase: ForgetPasswordUseCase
    
    init(useCase: ForgetPasswordUseCase) {
        self.useCase = useCase
    }
    
    func resetPassword(forgetPasswordRequest: ForgetPasswordRequest) {
        useCase.resetPassword(forgetPasswordRequest: forgetPasswordRequest) { [weak self] result in
            switch result {
            case .success(let resetPasswordResponse):
                if resetPasswordResponse.status == true {
                    DispatchQueue.main.async {
                        self?.presenter?.fetchingResetPasswordWithSucess(message: resetPasswordResponse.message ?? "")
                    }
                } else {
                    DispatchQueue.main.async {
                        self?.presenter?.fetchingWithError(resetPasswordResponse.message ?? "")
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.presenter?.fetchingWithError(error.rawValue.localized())
                }
            }
        }
    }
}
