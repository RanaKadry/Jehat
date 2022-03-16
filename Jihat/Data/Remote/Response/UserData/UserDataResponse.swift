/* 
Copyright (c) 2021 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct UserDataResponse : Codable {
    let id : String?
    let englishName : String?
    let arabicName : String?
	let phone : String?
	let email : String?
	let identificiationNumber : String?
	let arabicAddress : String?
	let englishAddress : String?
	let fax : String?
	let gender : String?
	let genderId : String?
	let nationality : String?
    let country : String?
	let countryId : String?

	enum CodingKeys: String, CodingKey {

		case id = "ID"
		case englishName = "Name_en"
		case arabicName = "Name_ar"
		case phone = "Mobile"
		case email = "Mail"
		case identificiationNumber = "Card"
		case arabicAddress = "Address_ar"
		case englishAddress = "Address_en"
		case fax = "Fax"
		case gender = "Gender"
		case genderId = "Gender_ID"
		case nationality = "Nationality"
        case country = "Country"
		case countryId = "Country_ID"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        englishName = try values.decodeIfPresent(String.self, forKey: .englishName)
        arabicName = try values.decodeIfPresent(String.self, forKey: .arabicName)
        phone = try values.decodeIfPresent(String.self, forKey: .phone)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        identificiationNumber = try values.decodeIfPresent(String.self, forKey: .identificiationNumber)
        arabicAddress = try values.decodeIfPresent(String.self, forKey: .arabicAddress)
        englishAddress = try values.decodeIfPresent(String.self, forKey: .englishAddress)
		fax = try values.decodeIfPresent(String.self, forKey: .fax)
		gender = try values.decodeIfPresent(String.self, forKey: .gender)
		genderId = try values.decodeIfPresent(String.self, forKey: .genderId)
		nationality = try values.decodeIfPresent(String.self, forKey: .nationality)
        country = try values.decodeIfPresent(String.self, forKey: .country)
		countryId = try values.decodeIfPresent(String.self, forKey: .countryId)
	}

    init(id: String?, englishName: String?, arabicName: String?, phone: String?, email: String?, identificiationNumber: String?, arabicAddress: String?, englishAddress: String?, fax: String?, gender: String?, genderId: String?, nationality: String?, country: String?, countryId: String?) {
        self.id = id
        self.englishName = englishName
        self.arabicName = arabicName
        self.phone = phone
        self.email = email
        self.identificiationNumber = identificiationNumber
        self.arabicAddress = arabicAddress
        self.englishAddress = englishAddress
        self.fax = fax
        self.gender = gender
        self.genderId = genderId
        self.nationality = nationality
        self.country = country
        self.countryId = countryId
    }
}
