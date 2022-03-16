//
//  SingleDelegateUseCase.swift
//  Jihat
//
//  Created by Ahmed Barghash on 27/10/2021.
//

import Foundation

class SingleDelegateUseCase {
    
    private let commissionerRepository: CommissionerRepository
    private let userRepository: UserRepository
    
    init(commissionerRepository: CommissionerRepository, userRepository: UserRepository) {
        self.commissionerRepository = commissionerRepository
        self.userRepository = userRepository
    }
    
    // ---------------------------
    // MARK: - SINGLE COMMISSIONER
    // ---------------------------
    
    func getSingleCommissioner(getSingleCommissionerRequest: EditDelegateRequest, completion: @escaping (Result<APIResponse<CommissionersResponse>, NetworkErrorType>) -> Void) {
        commissionerRepository.getSingleCommissioner(getSingleCommissionerRequest: getSingleCommissionerRequest, completion: completion)
    }
    
//    // ------------
//    // MARK: - USER
//    // ------------
//    var userToken: String? {
//        return userRepository.userToken
//    }
    
}
