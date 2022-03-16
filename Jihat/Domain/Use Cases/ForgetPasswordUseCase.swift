//
//  ForgetPasswordUseCase.swift
//  Jihat
//
//  Created by Peter Bassem on 26/10/2021.
//

import Foundation

class ForgetPasswordUseCase {
    
    private let userRepository: UserRepository
    
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    // -------------
    // MARK : - USER
    // -------------
    func resetPassword(forgetPasswordRequest: ForgetPasswordRequest, completion: @escaping (Result<APIResponse<AuthModel>, NetworkErrorType>) -> Void) {
        userRepository.resetPassword(forgetPasswordRequest: forgetPasswordRequest, completion: completion)
    }
}
