/* 
Copyright (c) 2021 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
class UserMeetingDetailsResponse : Codable {
	let meetingId : String?
	let meetingName : String?
	let meetingSubject : String?
	let meetingDiscription : String?
	let meetingDate : String?
	let meetingTime : String?
	let meetingStatus : String?
	let meetingManger : String?
	let stockShare : String?
	let attendEmployees : [String]?
	let absentEmployees : [String]?
	let attendClients : [String]?
	let absentClients : [String]?
	let candidates : [String]?
	let attachments : [String]?
    var attendFlag : String?
	let candidatesFlag : String?
	let note : String?
	let attendLabel : String?
	let attendText : String?
	let absentLabel : String?
	let absentText : String?
	let percentageLabel : String?
	let percentageText : String?

	enum CodingKeys: String, CodingKey {

		case meetingId = "Meeting_ID"
		case meetingName = "Meeting_Name"
		case meetingSubject = "Meeting_Subject"
		case meetingDiscription = "Meeting_Discription"
		case meetingDate = "Meeting_Date"
		case meetingTime = "Meeting_Time"
		case meetingStatus = "Meeting_Status"
		case meetingManger = "Meeting_Manger"
		case stockShare = "Stock_Share"
		case attendEmployees = "Attend_Employees"
		case absentEmployees = "Absent_Employees"
		case attendClients = "Attend_Clients"
		case absentClients = "Absent_Clients"
		case candidates = "Candidates"
		case attachments = "Attachments"
		case attendFlag = "Attend_btn_Flag"
		case candidatesFlag = "Candidates_btn_Flag"
		case note = "Note"
		case attendLabel = "Attend_Label"
		case attendText = "Attend_Text"
		case absentLabel = "Absent_Label"
		case absentText = "Absent_Text"
		case percentageLabel = "Percentage_Label"
		case percentageText = "Percentage_Text"
	}

	required init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		meetingId = try values.decodeIfPresent(String.self, forKey: .meetingId)
		meetingName = try values.decodeIfPresent(String.self, forKey: .meetingName)
		meetingSubject = try values.decodeIfPresent(String.self, forKey: .meetingSubject)
		meetingDiscription = try values.decodeIfPresent(String.self, forKey: .meetingDiscription)
		meetingDate = try values.decodeIfPresent(String.self, forKey: .meetingDate)
		meetingTime = try values.decodeIfPresent(String.self, forKey: .meetingTime)
		meetingStatus = try values.decodeIfPresent(String.self, forKey: .meetingStatus)
		meetingManger = try values.decodeIfPresent(String.self, forKey: .meetingManger)
		stockShare = try values.decodeIfPresent(String.self, forKey: .stockShare)
		attendEmployees = try values.decodeIfPresent([String].self, forKey: .attendEmployees)
		absentEmployees = try values.decodeIfPresent([String].self, forKey: .absentEmployees)
		attendClients = try values.decodeIfPresent([String].self, forKey: .attendClients)
		absentClients = try values.decodeIfPresent([String].self, forKey: .absentClients)
		candidates = try values.decodeIfPresent([String].self, forKey: .candidates)
		attachments = try values.decodeIfPresent([String].self, forKey: .attachments)
		attendFlag = try values.decodeIfPresent(String.self, forKey: .attendFlag)
		candidatesFlag = try values.decodeIfPresent(String.self, forKey: .candidatesFlag)
		note = try values.decodeIfPresent(String.self, forKey: .note)
		attendLabel = try values.decodeIfPresent(String.self, forKey: .attendLabel)
		attendText = try values.decodeIfPresent(String.self, forKey: .attendText)
		absentLabel = try values.decodeIfPresent(String.self, forKey: .absentLabel)
		absentText = try values.decodeIfPresent(String.self, forKey: .absentText)
		percentageLabel = try values.decodeIfPresent(String.self, forKey: .percentageLabel)
		percentageText = try values.decodeIfPresent(String.self, forKey: .percentageText)
	}

}
