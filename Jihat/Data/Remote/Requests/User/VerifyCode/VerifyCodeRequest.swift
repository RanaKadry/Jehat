//
//  VerifyCodeRequest.swift
//  Jihat
//
//  Created by Peter Bassem on 25/10/2021.
//

import Foundation

struct VerifyCodeRequest: Codable {
    
    let code: String?
    
    enum CodingKeys: String, CodingKey {
        case code = "v_code"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        code = try values.decodeIfPresent(String.self, forKey: .code)
    }
    
    init(code: String?) {
        self.code = code
    }
}
