/* 
Copyright (c) 2021 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct UserOrdersResponse : Codable {
	let ticketId : String?
	let subject : String?
	let detatils : String?
	let ticketCode : String?
	let ticketDate : String?
	let expectedDate : String?
	let status : String?
	let department : String?
	let type : String?
	let priority : String?
	let employee : String?

	enum CodingKeys: String, CodingKey {

		case ticketId = "Ticket_ID"
		case subject = "Subject"
		case detatils = "Detatils"
		case ticketCode = "Ticket_Code"
		case ticketDate = "Ticket_Date"
		case expectedDate = "Expected_Date"
		case status = "Status"
		case department = "Department"
		case type = "Type"
		case priority = "Priority"
		case employee = "Employee"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		ticketId = try values.decodeIfPresent(String.self, forKey: .ticketId)
		subject = try values.decodeIfPresent(String.self, forKey: .subject)
		detatils = try values.decodeIfPresent(String.self, forKey: .detatils)
		ticketCode = try values.decodeIfPresent(String.self, forKey: .ticketCode)
		ticketDate = try values.decodeIfPresent(String.self, forKey: .ticketDate)
		expectedDate = try values.decodeIfPresent(String.self, forKey: .expectedDate)
		status = try values.decodeIfPresent(String.self, forKey: .status)
		department = try values.decodeIfPresent(String.self, forKey: .department)
		type = try values.decodeIfPresent(String.self, forKey: .type)
		priority = try values.decodeIfPresent(String.self, forKey: .priority)
		employee = try values.decodeIfPresent(String.self, forKey: .employee)
	}

}
