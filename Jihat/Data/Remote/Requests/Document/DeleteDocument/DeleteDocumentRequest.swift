//
//  DeleteDocumentRequest.swift
//  Jihat
//
//  Created by Ahmed Barghash on 29/10/2021.
//

import Foundation

struct DeleteDocumentRequest: Codable {
    
    let userToken: String?
    let documentId: String?
    
    enum CodingKeys: String, CodingKey {
        case userToken = "Token"
        case documentId = "Group_ID"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        userToken = try values.decodeIfPresent(String.self, forKey: .userToken)
        documentId = try values.decodeIfPresent(String.self, forKey: .documentId)
    }
    
    init(userToken: String?, documentId: String?) {
        self.userToken = userToken
        self.documentId = documentId
    }
    
}
