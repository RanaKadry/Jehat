//
//  APIResponse.swift
//  MandoBee
//
//  Created by Peter Bassem on 28/08/2021.
//

import Foundation

struct APIResponse<T: Codable>: Codable {
    let status: Bool?
    let message: String?
    let data: T?
    
    enum CodingKeys: String, CodingKey {

        case status
        case message = "massage"
        case data
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        data = try values.decodeIfPresent(T.self, forKey: .data)
    }
}
