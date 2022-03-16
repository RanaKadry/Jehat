//
//  OrderAddAttachmentUseCase.swift
//  Jihat
//
//  Created by Peter Bassem on 04/12/2021.
//  Copyright © 2021 Jehat. All rights reserved.
//

import Foundation

class OrderAddAttachmentUseCase {
    
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
    func addOrderComment(addOrderCommentRequest: AddOrderCommentRequest, attachments: [String: [Data]], body: [String: Any], images: [Data], completion: @escaping (Result<APIResponse<AuthModel>, NetworkErrorType>) -> Void) {
        orderRepository.addOrderComment(addOrderCommentRequest: addOrderCommentRequest, attachments: attachments, body: body, images: images, completion: completion)
    }
}
