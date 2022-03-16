//
//  UserOrderDetailsRequest.swift
//  Jihat
//
//  Created by Peter Bassem on 31/10/2021.
//  Copyright © 2021 Jehat. All rights reserved.
//

import Foundation

struct UserOrderDetailsRequest: Codable {
    let userToken: String?
    let orderId: String?
    
    enum CodingKeys: String, CodingKey {
        case userToken = "Token"
        case orderId = "Tiket_ID"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        userToken = try values.decodeIfPresent(String.self, forKey: .userToken)
        orderId = try values.decodeIfPresent(String.self, forKey: .orderId)
    }
    
    init(userToken: String?, orderId: String?) {
        self.userToken = userToken
        self.orderId = orderId
    }
}
