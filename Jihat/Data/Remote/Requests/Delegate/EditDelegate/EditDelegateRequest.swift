//
//  EditDelegateRequest.swift
//  Jihat
//
//  Created by Ahmed Barghash on 26/10/2021.
//

import Foundation

struct EditDelegateRequest: Codable {
    
    let userToken: String?
    let delegateId: String?
    
    enum CodingKeys: String, CodingKey {
        case userToken = "Token"
        case delegateId = "ID"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        userToken = try values.decodeIfPresent(String.self, forKey: .userToken)
        delegateId = try values.decodeIfPresent(String.self, forKey: .delegateId)
    }
    
    init(userToken: String?, delegateId: String?) {
        self.userToken = userToken
        self.delegateId = delegateId
    }
    
}
