//
//  RemoteCommissionersDataSource.swift
//  Jihat
//
//  Created by Ahmed Barghash on 22/10/2021.
//

import Foundation

class RemoteCommissionersDataSource {
    
    func getCommissioners(from apiRouter: APIRouter, completion: @escaping (Result<APIResponse<[CommissionersResponse]>, NetworkErrorType>) -> Void) {
        APIClient.performRequest(route: apiRouter).execute { (result) in
            completion(.success(result))
        } onFailure: { (error) in
            completion(.failure(error))
        }
    }
    
    func addCommissioner(from apiRouter: APIRouter, completion: @escaping (Result<APIResponse<AuthModel>, NetworkErrorType>) -> Void) {
        APIClient.performRequest(route: apiRouter).execute { response in
            completion(.success(response))
        } onFailure: { error in
            completion(.failure(error))
        }
    }
    
    func getSingleCommissioner(from apiRouter: APIRouter, completion: @escaping (Result<APIResponse<CommissionersResponse>, NetworkErrorType>) -> Void) {
        APIClient.performRequest(route: apiRouter).execute { response in
            completion(.success(response))
        } onFailure: { error in
            completion(.failure(error))
        }
    }
    
    func updateCommissioner(from apiRouter: APIRouter, completion: @escaping (Result<APIResponse<AuthModel>,NetworkErrorType>) -> Void) {
        APIClient.performRequest(route: apiRouter).execute { response in
            completion(.success(response))
        } onFailure: { error in
            completion(.failure(error))
        }
    }
    
    func deleteCommissioner(from apiRouter: APIRouter, completion: @escaping (Result<APIResponse<AuthModel>,NetworkErrorType>) -> Void) {
        APIClient.performRequest(route: apiRouter).execute { response in
            completion(.success(response))
        } onFailure: { error in
            completion(.failure(error))
        }
    }
    
}
