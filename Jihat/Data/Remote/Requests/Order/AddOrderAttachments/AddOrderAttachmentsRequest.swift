//
//  AddOrderAttachmentsRequest.swift
//  Jihat
//
//  Created by Peter Bassem on 11/12/2021.
//  Copyright © 2021 Jehat. All rights reserved.
//

import Foundation

struct AddOrderAttachmentsRequest: Codable {
    let userToken: String?
    let replyId: String?
    
    enum CodingKeys: String, CodingKey {
        case userToken = "Token"
        case replyId = "Reply_id"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        userToken = try values.decodeIfPresent(String.self, forKey: .userToken)
        replyId = try values.decodeIfPresent(String.self, forKey: .replyId)
    }
    
    init(userToken: String?, replyId: String?) {
        self.userToken = userToken
        self.replyId = replyId
    }
}
