//
//  AddOrderCommentRequest.swift
//  Jihat
//
//  Created by Peter Bassem on 02/12/2021.
//  Copyright © 2021 Jehat. All rights reserved.
//

import Foundation

struct AddOrderCommentRequest: Codable {
    let userToken: String?
    let orderId: String?
    let comment: String?
    
    enum CodingKeys: String, CodingKey {
        case userToken = "Token"
        case orderId = "Ticket_ID"
        case comment = "Content"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        userToken = try values.decodeIfPresent(String.self, forKey: .userToken)
        orderId = try values.decodeIfPresent(String.self, forKey: .orderId)
        comment = try values.decodeIfPresent(String.self, forKey: .comment)
    }
    
    init(userToken: String?, orderId: String?, comment: String?) {
        self.userToken = userToken
        self.orderId = orderId
        self.comment = comment
    }
}
