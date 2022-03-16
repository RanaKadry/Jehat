//
//  OrderDetailsUseCase.swift
//  Jihat
//
//  Created by Peter Bassem on 31/10/2021.
//  Copyright © 2021 Jehat. All rights reserved.
//

import Foundation

class OrderDetailsUseCase {
    
    private let userRepository: UserRepository
    private let orderRepository: OrderRepository
    
    init(userRepository: UserRepository, orderRepository: OrderRepository) {
        self.userRepository = userRepository
        self.orderRepository = orderRepository
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
    func getOrderDetails(userOrderDetailsRequest: UserOrderDetailsRequest, completion: @escaping (Result<APIResponse<UserOrdersResponse>, NetworkErrorType>) -> Void) {
        orderRepository.getOrderDetails(userOrderDetailsRequest: userOrderDetailsRequest, completion: completion)
    }
    
    func getOrderDetailsComments(userORderDetailsCommentsRequest: UserOrderDetailsRequest, completion: @escaping (Result<APIResponse<[UserOrderCommentsResponse]>, NetworkErrorType>) -> Void) {
        orderRepository.getOrderDetailsComments(userORderDetailsCommentsRequest: userORderDetailsCommentsRequest, completion: completion)
    }
}
