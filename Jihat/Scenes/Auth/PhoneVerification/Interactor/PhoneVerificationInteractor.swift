//
//  PhoneVerificationInteractor.swift
//  Jihat
//
//  Created Peter Bassem on 18/09/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

// MARK: PhoneVerification Interactor -

class PhoneVerificationInteractor: PhoneVerificationInteractorInputProtocol {
    
    weak var presenter: PhoneVerificationInteractorOutputProtocol?
    private let useCase: PhoneVerificationUseCase
    
    init(useCase: PhoneVerificationUseCase) {
        self.useCase = useCase
    }
    
    var userId: String? {
        return useCase.userId
    }
    
    var sendSMSAgain: Bool {
        return useCase.sendSMS
    }
    
    func updateSendSMS(_ sendSMS: Bool) {
        useCase.updateSendSMS(sendSMS)
    }
    
    func resendVerificationCode(resendVerificationCodeRequest: ResendVerifiyCodeRequest) {
        useCase.resendVerificationCode(resendVerificationCodeRequest: resendVerificationCodeRequest) { [weak self] result in
            switch result {
            case .success(let resendCodeResponse):
                DispatchQueue.main.async {
                    self?.presenter?.fetchingWithMessage(resendCodeResponse.message ?? "")
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.presenter?.fetchingWithMessage(error.rawValue.localized())
                }
            }
        }
    }
    
    func sendVerificationCode(submitVerificationCodeRequest: VerifyCodeRequest) {
        useCase.sendVerificationCode(submitVerificationCodeRequest: submitVerificationCodeRequest) { [weak self] result in
            switch result {
            case .success(let submitCodeResponse):
                if submitCodeResponse.status == true {
                    DispatchQueue.main.async {
                        self?.presenter?.fetchingVerificationCode(message: submitCodeResponse.message ?? "")
                    }
                } else {
                    DispatchQueue.main.async {
                        self?.presenter?.fetchingWithMessage(submitCodeResponse.message ?? "")
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.presenter?.fetchingWithMessage(error.rawValue.localized())
                }
            }
        }
    }
    
    func updatedVerificationState(userVerified: Bool) {
        useCase.updatedVerificationState(userVerified: userVerified)
    }
}
