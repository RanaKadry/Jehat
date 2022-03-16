//
//  TransactionPropertiesRequest.swift
//  Jihat
//
//  Created by Peter Bassem on 29/11/2021.
//  Copyright © 2021 Jehat. All rights reserved.
//

import Foundation

struct TransactionPropertiesRequest: Codable {
    let transactionId: String?
    
    enum CodingKeys: String, CodingKey {
        case transactionId = "Trans_ID"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        transactionId = try values.decodeIfPresent(String.self, forKey: .transactionId)
    }
    
    init(transactionId: String?) {
        self.transactionId = transactionId
    }
}
