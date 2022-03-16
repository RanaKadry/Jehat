//
//  OrderRepositoryImp.swift
//  Jihat
//
//  Created by Peter Bassem on 30/10/2021.
//  Copyright © 2021 Jehat. All rights reserved.
//

import Foundation
import AVFoundation

class OrderRepositoryImp: OrderRepository {
    
    private let remoteOrderDataSource = RemoteOrderDataSource()
    
    func getUserOrders(userOrdersRequest: UserOrdersRequest, completion: @escaping (Result<APIResponse<[UserOrdersResponse]>, NetworkErrorType>) -> Void) {
        remoteOrderDataSource.getUserOrders(from: .getOrders(ordersRequest: userOrdersRequest), completion: completion)
    }
    
    func getDepartments(completion: @escaping (Result<APIResponse<[DepartmentsResponse]>, NetworkErrorType>) -> Void) {
        remoteOrderDataSource.getDepartments(from: .orderDepartments, completion: completion)
    }
    
    func getTransactionTypes(transactionTypesRequest: TransactionTypesRequest, completion: @escaping (Result<APIResponse<[TransactionTypesResponse]>, NetworkErrorType>) -> Void) {
        remoteOrderDataSource.getTransactionTypes(from: .orderTransactionTypes(transactionTypesRequest: transactionTypesRequest), completion: completion)
    }
    
    func getTransactionProperties(transactionPropertiesRequest: TransactionPropertiesRequest, completion: @escaping (Result<APIResponse<[PropertiesResponse]>, NetworkErrorType>) -> Void) {
        remoteOrderDataSource.getTransactionProperties(from: .orderTransactionProperties(transactionPropertiesRequest: transactionPropertiesRequest), completion: completion)
    }
    
    func getPriorities(completion: @escaping (Result<APIResponse<[PrioritiesResponse]>, NetworkErrorType>) -> Void) {
        remoteOrderDataSource.getPriorities(from: .orderPriorities, completion: completion)
    }
    
    func addNewOrder(addOrderRequest: AddOrderRequest, body: Data, completion: @escaping (Result<APIResponse<AuthModel>, NetworkErrorType>) -> Void) {
        remoteOrderDataSource.addNewOrder(from: KNetworkConstants.EndPoint.addOrder.rawValue, addOrderRequest: addOrderRequest, body: body, completion: completion)
    }
    
    func addOrderAttachments(addOrderAttachmentsRequest: AddOrderAttachmentsRequest, attachments: [String: [Data]], images: [Data], completion: @escaping (Result<APIResponse<AuthModel>, NetworkErrorType>) -> Void) {
        remoteOrderDataSource.addOrderAttachments(from: KNetworkConstants.EndPoint.addORderAttachments.rawValue, addOrderAttachmentsRequest: addOrderAttachmentsRequest, attachments: attachments, images: images, completion: completion)
    }
    
    func addOrder(addOrderRequest: AddOrderRequest, addOrderBodyRequest: [String: [AddOrderBodyRequest]], completion: @escaping (Result<APIResponse<AddOrderResponse>, NetworkErrorType>) -> Void) {
        remoteOrderDataSource.addOrder(from: .addOrder(addOrderRequest: addOrderRequest, addOrderBodyRequest: addOrderBodyRequest), completion: completion)
    }
    
    func getOrderDetails(userOrderDetailsRequest: UserOrderDetailsRequest, completion: @escaping (Result<APIResponse<UserOrdersResponse>, NetworkErrorType>) -> Void) {
        remoteOrderDataSource.getOrderDetails(from: .getOrderDetails(userOrderDetailsRequest: userOrderDetailsRequest), completion: completion)
    }
    
    func getOrderDetailsComments(userORderDetailsCommentsRequest: UserOrderDetailsRequest, completion: @escaping (Result<APIResponse<[UserOrderCommentsResponse]>, NetworkErrorType>) -> Void) {
        remoteOrderDataSource.getOrderComments(from: .getOrderCommentsUpdates(userOrderDetailsRequest: userORderDetailsCommentsRequest), completion: completion)
    }
    
    func addOrderComment(addOrderCommentRequest: AddOrderCommentRequest, attachments: [String: [Data]], body: [String: Any], images: [Data]? = nil, completion: @escaping (Result<APIResponse<AuthModel>, NetworkErrorType>) -> Void) {
        remoteOrderDataSource.addOrderComment(from: KNetworkConstants.EndPoint.orderAddComment.rawValue, addOrderCommentRequest: addOrderCommentRequest, attachments: attachments, body: body, images: images, completion: completion)
    }
    
    func getOrderFilterItems(completion: @escaping (Result<APIResponse<[TicketFilterItemsResponse]>, NetworkErrorType>) -> Void) {
        remoteOrderDataSource.getOrderFilterItems(from: .getTicketsFilterItems, completion: completion)
    }
}
