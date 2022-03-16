//
//  CommissionerRepository.swift
//  Jihat
//
//  Created by Ahmed Barghash on 22/10/2021.
//

import Foundation

protocol CommissionerRepository {
    func getCommissioners(commissionerRequest: BaseRequest, completion: @escaping (Result<APIResponse<[CommissionersResponse]>, NetworkErrorType>) -> Void )
    func addCommissioners(addCommissionerRequest: AddDelegateRequest, completion: @escaping (Result<APIResponse<AuthModel>,NetworkErrorType>) -> Void )
    func getSingleCommissioner(getSingleCommissionerRequest: EditDelegateRequest, completion: @escaping (Result<APIResponse<CommissionersResponse>, NetworkErrorType>) -> Void )
    func updateCommissioner(updateCommissionerRequest: UpdateDelegateRequest, completion: @escaping (Result<APIResponse<AuthModel>,NetworkErrorType>) -> Void )
    func deleteCommissioner(deleteCommissionerRequest: EditDelegateRequest, completion: @escaping (Result<APIResponse<AuthModel>,NetworkErrorType>) -> Void)
}
