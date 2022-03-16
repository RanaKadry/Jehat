/* 
Copyright (c) 2021 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct DocumentsResponse : Codable {
    let id : String?
	let arabicName : String?
	let englishName : String?
	let documentNumber : String?
	let endDate : String?
	let attachments : [DocumentsResponseAttachments]?

	enum CodingKeys: String, CodingKey {

		case id = "GroupID"
		case arabicName = "Name_ar"
		case englishName = "Name_en"
		case documentNumber = "Number"
		case endDate = "Exp_Date"
		case attachments = "Attachments"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        arabicName = try values.decodeIfPresent(String.self, forKey: .arabicName)
        englishName = try values.decodeIfPresent(String.self, forKey: .englishName)
        documentNumber = try values.decodeIfPresent(String.self, forKey: .documentNumber)
        endDate = try values.decodeIfPresent(String.self, forKey: .endDate)
		attachments = try values.decodeIfPresent([DocumentsResponseAttachments].self, forKey: .attachments)
	}

    init(id: String?, arabicName: String?, englishName: String?, documentNumber: String?, endDate: String?, attachments: [DocumentsResponseAttachments]?) {
        self.id = id
        self.arabicName = arabicName
        self.englishName = englishName
        self.documentNumber = documentNumber
        self.endDate = endDate
        self.attachments = attachments
    }
}
