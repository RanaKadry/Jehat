//
//  LoginRequest.swift
//  Jihat
//
//  Created by Peter Bassem on 16/10/2021.
//

import Foundation

struct LoginRequest: Codable {
    let id: String?
    let password: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "card"
        case password
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        password = try values.decodeIfPresent(String.self, forKey: .password)
    }
    
    init(id: String?, password: String?) {
        self.id = id
        self.password = password
    }
}
