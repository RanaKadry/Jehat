//
//  RemoteOrderDataSource.swift
//  Jihat
//
//  Created by Peter Bassem on 30/10/2021.
//  Copyright © 2021 Jehat. All rights reserved.
//

import Foundation

class RemoteOrderDataSource {
    
    func getUserOrders(from apiRouter: APIRouter, completion: @escaping (Result<APIResponse<[UserOrdersResponse]>, NetworkErrorType>) -> Void) {
        APIClient.performRequest(route: apiRouter).execute { response in
            completion(.success(response))
        } onFailure: { error in
            completion(.failure(error))
        }
    }
    
    func getDepartments(from apiRouter: APIRouter, completion: @escaping (Result<APIResponse<[DepartmentsResponse]>, NetworkErrorType>) -> Void) {
        APIClient.performRequest(route: apiRouter).execute { response in
            completion(.success(response))
        } onFailure: { error in
            completion(.failure(error))
        }
    }
    
    func getTransactionTypes(from apiRouter: APIRouter, completion: @escaping (Result<APIResponse<[TransactionTypesResponse]>, NetworkErrorType>) -> Void) {
        APIClient.performRequest(route: apiRouter).execute { response in
            completion(.success(response))
        } onFailure: { error in
            completion(.failure(error))
        }
    }
    
    func getTransactionProperties(from apiRouter: APIRouter, completion: @escaping (Result<APIResponse<[PropertiesResponse]>, NetworkErrorType>) -> Void) {
        APIClient.performRequest(route: apiRouter).execute { response in
            completion(.success(response))
        } onFailure: { error in
            completion(.failure(error))
        }
    }
    
    func getPriorities(from apiRouter: APIRouter, completion: @escaping (Result<APIResponse<[PrioritiesResponse]>, NetworkErrorType>) -> Void) {
        APIClient.performRequest(route: apiRouter).execute { response in
            completion(.success(response))
        } onFailure: { error in
            completion(.failure(error))
        }
    }
    
    func addNewOrder(from endPoint: String, addOrderRequest: AddOrderRequest, body: Data, completion: @escaping (Result<APIResponse<AuthModel>, NetworkErrorType>) -> Void) {
        APIClient.performCustomRequest(endUrl: endPoint, paramsType: AddOrderRequest.self, params: addOrderRequest, body: body, type: APIResponse<AuthModel>.self, completion: completion)
    }

    func addOrderAttachments(from endPoint: String, addOrderAttachmentsRequest: AddOrderAttachmentsRequest, attachments: [String: [Data]], images: [Data], completion: @escaping (Result<APIResponse<AuthModel>, NetworkErrorType>) -> Void) {
        APIClient.uploadAttachments(endUrl: endPoint, paramsType: AddOrderAttachmentsRequest.self, params: addOrderAttachmentsRequest, attachments: attachments, body: nil, images: images, type: APIResponse<AuthModel>.self, completion: completion)
    }
    
    func addOrder(from apiRouter: APIRouter, completion: @escaping (Result<APIResponse<AddOrderResponse>, NetworkErrorType>) -> Void) {
        APIClient.performRequest(route: apiRouter).execute { response in
            completion(.success(response))
        } onFailure: { error in
            completion(.failure(error))
        }
    }
    
    func getOrderDetails(from apiRouter: APIRouter, completion: @escaping (Result<APIResponse<UserOrdersResponse>, NetworkErrorType>) -> Void) {
        APIClient.performRequest(route: apiRouter).execute { response in
            completion(.success(response))
        } onFailure: { error in
            completion(.failure(error))
        }
    }
    
    func getOrderComments(from apiRouter: APIRouter, completion: @escaping (Result<APIResponse<[UserOrderCommentsResponse]>, NetworkErrorType>) -> Void) {
        APIClient.performRequest(route: apiRouter).execute { response in
            completion(.success(response))
        } onFailure: { error in
            completion(.failure(error))
        }
    }
    
    func addOrderComment(from endPoint: String, addOrderCommentRequest: AddOrderCommentRequest, attachments: [String: [Data]], body: [String: Any], images: [Data]? = nil, completion: @escaping (Result<APIResponse<AuthModel>, NetworkErrorType>) -> Void) {
        APIClient.uploadAttachments(endUrl: endPoint, paramsType: AddOrderCommentRequest.self, params: addOrderCommentRequest, attachments: attachments, body: body, images: images, type: APIResponse<AuthModel>.self, completion: completion)
    }
    
    func getOrderFilterItems(from apiRouter: APIRouter, completion: @escaping (Result<APIResponse<[TicketFilterItemsResponse]>, NetworkErrorType>) -> Void) {
        APIClient.performRequest(route: apiRouter).execute { response in
            completion(.success(response))
        } onFailure: { error in
            completion(.failure(error))
        }
    }
}
