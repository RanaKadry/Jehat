/* 
Copyright (c) 2021 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct UserOrderCommentsResponse : Codable {
	let id : String?
	let content : String?
	let status : String?
	let date : String?
	let by : String?
	let attachment : [String]?
	let audio : String?
	let deletedComFlag : String?
    
    var isPlayingAudio = false

	enum CodingKeys: String, CodingKey {

		case id = "ID"
		case content = "Content"
		case status = "Status"
		case date = "Date"
		case by = "By"
		case attachment = "Attachment"
		case audio = "Audio"
		case deletedComFlag = "Deleted_Com_Flag"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
		content = try values.decodeIfPresent(String.self, forKey: .content)
		status = try values.decodeIfPresent(String.self, forKey: .status)
		date = try values.decodeIfPresent(String.self, forKey: .date)
		by = try values.decodeIfPresent(String.self, forKey: .by)
		attachment = try values.decodeIfPresent([String].self, forKey: .attachment)
		audio = try values.decodeIfPresent(String.self, forKey: .audio)
        deletedComFlag = try values.decodeIfPresent(String.self, forKey: .deletedComFlag)
	}

}
