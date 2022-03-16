//
//  TransactionTypesRequest.swift
//  Jihat
//
//  Created by Peter Bassem on 30/10/2021.
//  Copyright © 2021 Jehat. All rights reserved.
//

import Foundation

struct TransactionTypesRequest: Codable {
    let departmentId: String?
    
    enum CodingKeys: String, CodingKey {
        case departmentId = "Dep_ID"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        departmentId = try values.decodeIfPresent(String.self, forKey: .departmentId)
    }
    
    init(departmentId: String?) {
        self.departmentId = departmentId
    }
}
