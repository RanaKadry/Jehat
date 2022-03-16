//
//  ResendVerifiyCodeRequest.swift
//  Jihat
//
//  Created by Peter Bassem on 25/10/2021.
//

import Foundation

struct ResendVerifiyCodeRequest: Codable {
    
    let clientId: String?
    
    enum CodingKeys: String, CodingKey {
        case clientId = "C_ID"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        clientId = try values.decodeIfPresent(String.self, forKey: .clientId)
    }
    
    init(clientId: String?) {
        self.clientId = clientId
    }
}
