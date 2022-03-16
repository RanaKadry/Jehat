//
//  UpdateUserDataRequest.swift
//  Jihat
//
//  Created by Peter Bassem on 23/10/2021.
//

import Foundation

struct UpdateUserDataRequest: Codable {
    var userToken: String?
    var englishName : String?
    var arabicName : String?
    var phone : String?
    var email : String?
    var identificiationNumber : String?
    var arabicAddress : String?
    var englishAddress : String?
    var fax : String?
    var genderId : String?
    var countryId : String?
    
    enum CodingKeys: String, CodingKey {

        case userToken = "Token"
        case englishName = "Name_en"
        case arabicName = "Name_ar"
        case phone = "Mobile"
        case email = "Mail"
        case identificiationNumber = "Card"
        case arabicAddress = "Address_ar"
        case englishAddress = "Address_en"
        case fax = "Fax"
        case genderId = "Gender_ID"
        case countryId = "Country_ID"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        userToken = try values.decodeIfPresent(String.self, forKey: .userToken)
        englishName = try values.decodeIfPresent(String.self, forKey: .englishName)
        arabicName = try values.decodeIfPresent(String.self, forKey: .arabicName)
        phone = try values.decodeIfPresent(String.self, forKey: .phone)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        identificiationNumber = try values.decodeIfPresent(String.self, forKey: .identificiationNumber)
        arabicAddress = try values.decodeIfPresent(String.self, forKey: .arabicAddress)
        englishAddress = try values.decodeIfPresent(String.self, forKey: .englishAddress)
        fax = try values.decodeIfPresent(String.self, forKey: .fax)
        genderId = try values.decodeIfPresent(String.self, forKey: .genderId)
        countryId = try values.decodeIfPresent(String.self, forKey: .countryId)
    }
    
    init(userToken: String?, englishName: String?, arabicName: String?, phone: String?, email: String?, identificiationNumber: String?, arabicAddress: String?, englishAddress: String?, fax: String?, genderId: String?, countryId: String?) {
        self.userToken = userToken
        self.englishName = englishName
        self.arabicName = arabicName
        self.phone = phone
        self.email = email
        self.identificiationNumber = identificiationNumber
        self.arabicAddress = arabicAddress
        self.englishAddress = englishAddress
        self.fax = fax
        self.genderId = genderId
        self.countryId = countryId
    }
}
