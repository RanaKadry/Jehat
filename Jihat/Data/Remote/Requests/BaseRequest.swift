//
//  BaseRequest.swift
//  MandoBee
//
//  Created by Peter Bassem on 23/06/2021.
//

import Foundation

class BaseRequest: Codable {
    
    var userToken: String?
    
    enum CodingKeys: String, CodingKey {
        case userToken = "Token"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        userToken = try values.decodeIfPresent(String.self, forKey: .userToken)
    }
    
    init(userToken: String?) {
        self.userToken = userToken
    }
}
