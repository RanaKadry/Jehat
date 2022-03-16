//
//  DelegatesUseCase.swift
//  Jihat
//
//  Created by Ahmed Barghash on 22/10/2021.
//

import Foundation

class DelegatesUseCase {
    
    private let commissionerRepository: CommissionerRepository
    private let userRepository: UserRepository
    
    init(commissionerRepository: CommissionerRepository, userRepository: UserRepository) {
        self.commissionerRepository = commissionerRepository
        self.userRepository = userRepository
    }
    
    // --------------------
    // MARK: - COMMISSIONER
    // --------------------
    func getCommissioners(commissionerRequest: BaseRequest, completion: @escaping (Result<APIResponse<[CommissionersResponse]>, NetworkErrorType>) -> Void) {
        commissionerRepository.getCommissioners(commissionerRequest: commissionerRequest, completion: completion)
    }
    
    // ---------------------------
    // MARK: - DELETE COMMISSIONER
    // ---------------------------
    
    func deleteCommissioner(deleteCommissionerRequest: EditDelegateRequest, completion: @escaping (Result<APIResponse<AuthModel>,NetworkErrorType>) -> Void) {
        commissionerRepository.deleteCommissioner(deleteCommissionerRequest: deleteCommissionerRequest, completion: completion)
    }
    
    // ------------
    // MARK: - USER
    // ------------
    var userToken: String? {
        return userRepository.userToken
    }
}
