//
//  RegisterRequest.swift
//  Jihat
//
//  Created by Peter Bassem on 16/10/2021.
//

import Foundation

struct RegisterRequest: Codable {
    
    let country: String?
    let arabicName: String?
    let englishName: String?
    let mobile: String?
    let email: String?
    let card: String?
    let password: String?
    let gender: String?
    
    enum CodingKeys: String, CodingKey {
        case country, gender
        case arabicName = "Name_ar"
        case englishName = "Name_en"
        case mobile = "Mobile"
        case email = "Mail"
        case card = "Card"
        case password = "Pass"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        country = try values.decodeIfPresent(String.self, forKey: .country)
        arabicName = try values.decodeIfPresent(String.self, forKey: .arabicName)
        englishName = try values.decodeIfPresent(String.self, forKey: .englishName)
        mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        card = try values.decodeIfPresent(String.self, forKey: .card)
        password = try values.decodeIfPresent(String.self, forKey: .password)
        gender = try values.decodeIfPresent(String.self, forKey: .gender)
    }
    
    init(country: String?, arabicName: String?, englishName: String?, mobile: String?, email: String?, card: String?, password: String?, gender: String?) {
        self.country = country
        self.arabicName = arabicName
        self.englishName = englishName
        self.mobile = mobile
        self.email = email
        self.card = card
        self.password = password
        self.gender = gender
    }
}
