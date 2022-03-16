//
//  EditDocumentRequest.swift
//  Jihat
//
//  Created by Peter Bassem on 13/11/2021.
//  Copyright © 2021 Jehat. All rights reserved.
//

import Foundation

struct EditDocumentRequest: Codable {
    let userToken: String?
    let documentId: String?
    let arabicName: String?
    let englishName: String?
    let number: String?
    let expirationDate: String?
    
    enum CodingKeys: String, CodingKey {
        case userToken = "Token"
        case documentId = "Group_ID"
        case arabicName = "Name_ar"
        case englishName = "Name_en"
        case number = "Number"
        case expirationDate = "Exp_Date"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        userToken = try values.decodeIfPresent(String.self, forKey: .userToken)
        documentId = try values.decodeIfPresent(String.self, forKey: .documentId)
        arabicName = try values.decodeIfPresent(String.self, forKey: .arabicName)
        englishName = try values.decodeIfPresent(String.self, forKey: .englishName)
        number = try values.decodeIfPresent(String.self, forKey: .number)
        expirationDate = try values.decodeIfPresent(String.self, forKey: .expirationDate)
    }
    
    init(userToken: String?, documentId: String?, arabicName: String?, englishName: String?, number: String?, expirationDate: String?) {
        self.userToken = userToken
        self.documentId = documentId
        self.arabicName = arabicName
        self.englishName = englishName
        self.number = number
        self.expirationDate = expirationDate
    }
}
