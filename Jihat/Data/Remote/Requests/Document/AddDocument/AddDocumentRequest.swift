//
//  AddDocumentRequest.swift
//  Jihat
//
//  Created by Peter Bassem on 05/11/2021.
//  Copyright © 2021 Jehat. All rights reserved.
//

import Foundation

struct AddDocumentRequest: Codable {
    let userToken: String?
    let arabicName: String?
    let englishName: String?
    let number: String?
    let expirationDate: String?
    
    enum CodingKeys: String, CodingKey {
        case userToken = "Token"
        case arabicName = "Name_ar"
        case englishName = "Name_en"
        case number = "Number"
        case expirationDate = "Exp_Date"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        userToken = try values.decodeIfPresent(String.self, forKey: .userToken)
        arabicName = try values.decodeIfPresent(String.self, forKey: .arabicName)
        englishName = try values.decodeIfPresent(String.self, forKey: .englishName)
        number = try values.decodeIfPresent(String.self, forKey: .number)
        expirationDate = try values.decodeIfPresent(String.self, forKey: .expirationDate)
    }
    
    init(userToken: String?, arabicName: String?, englishName: String?, number: String?, expirationDate: String?) {
        self.userToken = userToken
        self.arabicName = arabicName
        self.englishName = englishName
        self.number = number
        self.expirationDate = expirationDate
    }
}
