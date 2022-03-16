//
//  ForgetPasswordRequest.swift
//  Jihat
//
//  Created by Peter Bassem on 26/10/2021.
//

import Foundation

struct ForgetPasswordRequest: Codable {
    let email: String?
    
    enum CodingKeys: String, CodingKey {
        case email = "mail"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        email = try values.decodeIfPresent(String.self, forKey: .email)
    }
    
    init(email: String?) {
        self.email = email
    }
}
