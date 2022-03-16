//
//  AddDelegateUseCase.swift
//  Jihat
//
//  Created by Ahmed Barghash on 24/10/2021.
//

import Foundation

class AddDelegateUseCase {
    
    private let commissionerRepository: CommissionerRepository
    private let userRepository: UserRepository
    
    init(commissionerRepository: CommissionerRepository, userRepository: UserRepository) {
        self.commissionerRepository = commissionerRepository
        self.userRepository = userRepository
    }
    
    // --------------------
    // MARK: - COMMISSIONER
    // --------------------
    
    func addCommissioner(addCommissionerRequest: AddDelegateRequest, completion: @escaping (Result<APIResponse<AuthModel>,NetworkErrorType>) -> Void) {
        commissionerRepository.addCommissioners(addCommissionerRequest: addCommissionerRequest, completion: completion)
    }
    
    // ---------------------------
    // MARK: - UPDATE COMMISSIONER
    // ---------------------------
    
    func updateCommissioner(updateCommissionerRequest: UpdateDelegateRequest, completion: @escaping (Result<APIResponse<AuthModel>,NetworkErrorType>) -> Void) {
        commissionerRepository.updateCommissioner(updateCommissionerRequest: updateCommissionerRequest, completion: completion)
    }
    
    // ------------
    // MARK: - USER
    // ------------
    var userToken: String? {
        return userRepository.userToken
    }
}
