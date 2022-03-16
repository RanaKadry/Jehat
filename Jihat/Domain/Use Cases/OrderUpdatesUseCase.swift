//
//  OrderUpdatesUseCase.swift
//  Jihat
//
//  Created by Peter Bassem on 15/12/2021.
//  Copyright © 2021 Jehat. All rights reserved.
//

import Foundation

class OrderUpdatesUseCase {
    private let userRepoistory: UserRepository
    private let orderRepository: OrderRepository
    private let documentRepository: DocumentRepository
    
    init(userRepoistory: UserRepository, orderRepository: OrderRepository, documentRepository: DocumentRepository) {
        self.userRepoistory = userRepoistory
        self.orderRepository = orderRepository
        self.documentRepository = documentRepository
    }
    
    // ------------
    // MARK: - USER
    // ------------
    var userToken: String? {
        return userRepoistory.userToken
    }
    
    // -------------
    // MARK: - ORDER
    // -------------
    func getOrderDetailsComments(userORderDetailsCommentsRequest: UserOrderDetailsRequest, completion: @escaping (Result<APIResponse<[UserOrderCommentsResponse]>, NetworkErrorType>) -> Void) {
        orderRepository.getOrderDetailsComments(userORderDetailsCommentsRequest: userORderDetailsCommentsRequest, completion: completion)
    }
    
    // ----------------
    // MARK: - DOCUEMNT
    // ----------------
    func downloadDocument(fileurl: URL, completion: @escaping (URL?) -> Void) {
        documentRepository.downloadDocument(fileurl: fileurl, completion: completion)
    }
}
