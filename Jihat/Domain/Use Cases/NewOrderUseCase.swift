//
//  NewOrderUseCase.swift
//  Jihat
//
//  Created by Peter Bassem on 30/10/2021.
//  Copyright © 2021 Jehat. All rights reserved.
//

import Foundation

class NewOrderUseCase {
    
    private let orderRepository: OrderRepository
    private let userRepository: UserRepository
    
    init(orderRepository: OrderRepository, userRepository: UserRepository) {
        self.orderRepository = orderRepository
        self.userRepository = userRepository
    }
    
    // ------------
    // MARK: - USER
    // ------------
    var userToken: String? {
        return userRepository.userToken
    }
    
    // -------------
    // MARK: - ORDER
    // -------------
    func getDepartments(completion: @escaping (Result<APIResponse<[DepartmentsResponse]>, NetworkErrorType>) -> Void) {
        orderRepository.getDepartments(completion: completion)
    }
    
    func getTransactionTypes(transactionTypesRequest: TransactionTypesRequest, completion: @escaping (Result<APIResponse<[TransactionTypesResponse]>, NetworkErrorType>) -> Void) {
        orderRepository.getTransactionTypes(transactionTypesRequest: transactionTypesRequest, completion: completion)
    }
    
    func getTransactionProperties(transactionPropertiesRequest: TransactionPropertiesRequest, completion: @escaping (Result<APIResponse<[PropertiesResponse]>, NetworkErrorType>) -> Void) {
        orderRepository.getTransactionProperties(transactionPropertiesRequest: transactionPropertiesRequest, completion: completion)
    }
    
    func getPriorities(completion: @escaping (Result<APIResponse<[PrioritiesResponse]>, NetworkErrorType>) -> Void) {
        orderRepository.getPriorities(completion: completion)
    }
    
    func addNewOrder(addOrderRequest: AddOrderRequest, body: Data, completion: @escaping (Result<APIResponse<AuthModel>, NetworkErrorType>) -> Void) {
        orderRepository.addNewOrder(addOrderRequest: addOrderRequest, body: body, completion: completion)
    }
    
    func addOrderAttachments(addOrderAttachmentsRequest: AddOrderAttachmentsRequest, attachments: [String: [Data]], images: [Data], completion: @escaping (Result<APIResponse<AuthModel>, NetworkErrorType>) -> Void) {
        orderRepository.addOrderAttachments(addOrderAttachmentsRequest: addOrderAttachmentsRequest, attachments: attachments, images: images, completion: completion)
    }
    
    func addOrder(addOrderRequest: AddOrderRequest, addOrderBodyRequest: [String: [AddOrderBodyRequest]], completion: @escaping (Result<APIResponse<AddOrderResponse>, NetworkErrorType>) -> Void) {
        orderRepository.addOrder(addOrderRequest: addOrderRequest, addOrderBodyRequest: addOrderBodyRequest, completion: completion)
    }
}
