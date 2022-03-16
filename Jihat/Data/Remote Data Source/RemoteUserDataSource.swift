//
//  RemoteUserDataSource.swift
//  Jihat
//
//  Created by Peter Bassem on 16/10/2021.
//

import Foundation

class RemoteUserDataSource {
    
    func login(from apiRouter: APIRouter, completion: @escaping (Result<APIResponse<AuthModel>, NetworkErrorType>) -> Void) {
        APIClient.performRequest(route: apiRouter).execute { response in
            completion(.success(response))
        } onFailure: { error in
            completion(.failure(error))
        }
    }
    
    func resetPassword(from apiRouter: APIRouter, completion: @escaping (Result<APIResponse<AuthModel>, NetworkErrorType>) -> Void) {
        APIClient.performRequest(route: apiRouter).execute { response in
            completion(.success(response))
        } onFailure: { error in
            completion(.failure(error))
        }
    }
    
    func register(from apiRouter: APIRouter, completion: @escaping (Result<APIResponse<AuthModel>, NetworkErrorType>) -> Void) {
        APIClient.performRequest(route: apiRouter).execute { response in
            completion(.success(response))
        } onFailure: { error in
            completion(.failure(error))
        }
    }
    
    func getUserCountires(from apiRouter: APIRouter, completion: @escaping (Result<APIResponse<[CountriesModel]>, NetworkErrorType>) -> Void) {
        APIClient.performRequest(route: apiRouter).execute { response in
            completion(.success(response))
        } onFailure: { error in
            completion(.failure(error))
        }
    }
    
    func resendVerificationCode(from apiRouter: APIRouter, completion: @escaping (Result<APIResponse<AuthModel>, NetworkErrorType>) -> Void) {
        APIClient.performRequest(route: apiRouter).execute { response in
            completion(.success(response))
        } onFailure: { error in
            completion(.failure(error))
        }
    }
    
    func submitVerificationCode(from apiRouter: APIRouter, completion: @escaping (Result<APIResponse<AuthModel>, NetworkErrorType>) -> Void) {
        APIClient.performRequest(route: apiRouter).execute { response in
            completion(.success(response))
        } onFailure: { error in
            completion(.failure(error))
        }
    }
    
    func getUser(from apiRouter: APIRouter, completion: @escaping (Result<APIResponse<UserDataResponse>, NetworkErrorType>) -> Void) {
        APIClient.performRequest(route: apiRouter).execute { response in
            completion(.success(response))
        } onFailure: { error in
            completion(.failure(error))
        }
    }
    
    func updateUser(from apiRouter: APIRouter, completion: @escaping (Result<APIResponse<AuthModel>, NetworkErrorType>) -> Void) {
        APIClient.performRequest(route: apiRouter).execute { response in
            completion(.success(response))
        } onFailure: { error in
            completion(.failure(error))
        }
    }
    
    func logoutUser(from apiRouter: APIRouter, completion: @escaping (Result<APIResponse<AuthModel>, NetworkErrorType>) -> Void) {
        APIClient.performRequest(route: apiRouter).execute { response in
            completion(.success(response))
        } onFailure: { error in
            completion(.failure(error))
        }
    }
}
