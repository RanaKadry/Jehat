//
//  DocumentDetailsRequest.swift
//  Jihat
//
//  Created by Peter Bassem on 06/11/2021.
//  Copyright © 2021 Jehat. All rights reserved.
//

import Foundation

struct DocumentDetailsRequest: Codable {
    let userToken: String?
    let id: String?
    
    enum CodingKeys: String, CodingKey {
        case userToken = "Token"
        case id = "Group_ID"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        userToken = try values.decodeIfPresent(String.self, forKey: .userToken)
        id = try values.decodeIfPresent(String.self, forKey: .id)
    }
    
    init(userToken: String?, id: String?) {
        self.userToken = userToken
        self.id = id
    }
}
