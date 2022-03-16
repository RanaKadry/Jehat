//
//  PhoneVerificationUseCase.swift
//  Jihat
//
//  Created by Peter Bassem on 25/10/2021.
//

import Foundation
import PromisedFuture

class PhoneVerificationUseCase {
    
    private let userRepository: UserRepository
    
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    // ------------
    // MARK: - USER
    // ------------
    var sendSMS: Bool {
        return userRepository.sendSMS
    }
    
    var userId: String? {
        return userRepository.userId
    }
    
    func updateSendSMS(_ sendSMS: Bool) {
        userRepository.updateSendSMS(sendSMS)
    }
    
    func resendVerificationCode(resendVerificationCodeRequest: ResendVerifiyCodeRequest, completion: @escaping (Result<APIResponse<AuthModel>, NetworkErrorType>) -> Void) {
        userRepository.resendVerificationCode(resendVerificationCodeRequest: resendVerificationCodeRequest, completion: completion)
    }
    
    func sendVerificationCode(submitVerificationCodeRequest: VerifyCodeRequest, completion: @escaping (Result<APIResponse<AuthModel>, NetworkErrorType>) -> Void) {
        userRepository.submitVerificationCode(submitVerificationCodeRequest: submitVerificationCodeRequest, completion: completion)
    }
    
    func updatedVerificationState(userVerified: Bool) {
        userRepository.setUserVerified(userVerified)
    }
}
