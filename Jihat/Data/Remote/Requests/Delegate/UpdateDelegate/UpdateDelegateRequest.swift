//
//  UpdateDelegate.swift
//  Jihat
//
//  Created by Ahmed Barghash on 27/10/2021.
//

import Foundation

struct UpdateDelegateRequest: Codable {
    
    let userToken: String?
    let delegateId: String?
    let arabicName: String?
    let englishName: String?
    let email: String?
    let phone: String?
    
    enum CodingKeys: String, CodingKey {
        case userToken = "Token"
        case delegateId = "ID"
        case arabicName = "Name_ar"
        case englishName = "Name_en"
        case email = "Mail"
        case phone = "Mobile"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        userToken = try values.decodeIfPresent(String.self, forKey: .userToken)
        delegateId = try values.decodeIfPresent(String.self, forKey: .delegateId)
        arabicName = try values.decodeIfPresent(String.self, forKey: .arabicName)
        englishName = try values.decodeIfPresent(String.self, forKey: .englishName)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        phone = try values.decodeIfPresent(String.self, forKey: .phone)
    }
    
    init(userToken: String?, delegateId: String? , arabicName: String?, englishName: String?, email: String?, phone: String?) {
        self.userToken = userToken
        self.delegateId = delegateId
        self.arabicName = arabicName
        self.englishName = englishName
        self.email = email
        self.phone = phone
    }
}
