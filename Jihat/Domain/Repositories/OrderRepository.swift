//
//  OrderRepository.swift
//  Jihat
//
//  Created by Peter Bassem on 30/10/2021.
//  Copyright © 2021 Jehat. All rights reserved.
//

import Foundation

protocol OrderRepository {
    func getUserOrders(userOrdersRequest: UserOrdersRequest, completion: @escaping (Result<APIResponse<[UserOrdersResponse]>, NetworkErrorType>) -> Void)
    func getDepartments(completion: @escaping (Result<APIResponse<[DepartmentsResponse]>, NetworkErrorType>) -> Void)
    func getTransactionTypes(transactionTypesRequest: TransactionTypesRequest, completion: @escaping (Result<APIResponse<[TransactionTypesResponse]>, NetworkErrorType>) -> Void)
    func getTransactionProperties(transactionPropertiesRequest: TransactionPropertiesRequest, completion: @escaping (Result<APIResponse<[PropertiesResponse]>, NetworkErrorType>) -> Void)
    func getPriorities(completion: @escaping (Result<APIResponse<[PrioritiesResponse]>, NetworkErrorType>) -> Void)
    func addNewOrder(addOrderRequest: AddOrderRequest, body: Data, completion: @escaping (Result<APIResponse<AuthModel>, NetworkErrorType>) -> Void)
    func addOrderAttachments(addOrderAttachmentsRequest: AddOrderAttachmentsRequest, attachments: [String: [Data]], images: [Data], completion: @escaping (Result<APIResponse<AuthModel>, NetworkErrorType>) -> Void)
    func addOrder(addOrderRequest: AddOrderRequest, addOrderBodyRequest: [String: [AddOrderBodyRequest]], completion: @escaping (Result<APIResponse<AddOrderResponse>, NetworkErrorType>) -> Void)
    func getOrderDetails(userOrderDetailsRequest: UserOrderDetailsRequest, completion: @escaping (Result<APIResponse<UserOrdersResponse>, NetworkErrorType>) -> Void)
    func getOrderDetailsComments(userORderDetailsCommentsRequest: UserOrderDetailsRequest, completion: @escaping (Result<APIResponse<[UserOrderCommentsResponse]>, NetworkErrorType>) -> Void)
    func addOrderComment(addOrderCommentRequest: AddOrderCommentRequest, attachments: [String: [Data]], body: [String: Any], images: [Data]?, completion: @escaping (Result<APIResponse<AuthModel>, NetworkErrorType>) -> Void)
    func getOrderFilterItems(completion: @escaping (Result<APIResponse<[TicketFilterItemsResponse]>, NetworkErrorType>) -> Void)
}
