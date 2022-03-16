//
//  CommissionerRepositoryImp.swift
//  Jihat
//
//  Created by Ahmed Barghash on 22/10/2021.
//

import Foundation

class CommissionerRepositoryImp: CommissionerRepository {
    
    private let remoteCommissionersDataSource = RemoteCommissionersDataSource()
    
    func getCommissioners(commissionerRequest: BaseRequest, completion: @escaping (Result<APIResponse<[CommissionersResponse]>, NetworkErrorType>) -> Void) {
        remoteCommissionersDataSource.getCommissioners(from: .getCommissioners(commissionersRequest: commissionerRequest), completion: completion)
    }
    
    func addCommissioners(addCommissionerRequest: AddDelegateRequest, completion: @escaping (Result<APIResponse<AuthModel>, NetworkErrorType>) -> Void) {
        remoteCommissionersDataSource.addCommissioner(from: .addCommissioners(addCommissionersRequest: addCommissionerRequest), completion: completion)
    }
    
    func getSingleCommissioner(getSingleCommissionerRequest: EditDelegateRequest, completion: @escaping (Result<APIResponse<CommissionersResponse>, NetworkErrorType>) -> Void) {
        remoteCommissionersDataSource.getSingleCommissioner(from: .getSingleCommissioner(singleCommissionerRequest: getSingleCommissionerRequest), completion: completion)
    }
    
    func updateCommissioner(updateCommissionerRequest: UpdateDelegateRequest, completion: @escaping (Result<APIResponse<AuthModel>,NetworkErrorType>) -> Void ) {
        remoteCommissionersDataSource.updateCommissioner(from: .updateCommissioner(updateCommissionerRequest: updateCommissionerRequest), completion: completion)
    }
    
    func deleteCommissioner(deleteCommissionerRequest: EditDelegateRequest, completion: @escaping (Result<APIResponse<AuthModel>,NetworkErrorType>) -> Void) {
        remoteCommissionersDataSource.deleteCommissioner(from: .deleteCommissioner(deleteCommissionerRequest: deleteCommissionerRequest), completion: completion)
    }
    
}
