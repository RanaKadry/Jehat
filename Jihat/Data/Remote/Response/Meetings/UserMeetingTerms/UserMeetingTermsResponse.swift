/* 
Copyright (c) 2021 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
class UserMeetingTermsResponse : Codable {
	let id : String?
	let term : String?
	let vote : String?
	var voteFlag : String?
	let editFlag : String?
	let countVotes : String?
	let countAgree : String?
	let countNotAgree : String?

	enum CodingKeys: String, CodingKey {

		case id = "ID"
		case term = "Term"
		case vote = "Vote"
		case voteFlag = "Vote_Flage"
		case editFlag = "Edit_Flage"
		case countVotes = "count_Votes"
		case countAgree = "count_Agree"
		case countNotAgree = "count_Not_Agree"
	}

	required init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
		term = try values.decodeIfPresent(String.self, forKey: .term)
		vote = try values.decodeIfPresent(String.self, forKey: .vote)
		voteFlag = try values.decodeIfPresent(String.self, forKey: .voteFlag)
		editFlag = try values.decodeIfPresent(String.self, forKey: .editFlag)
		countVotes = try values.decodeIfPresent(String.self, forKey: .countVotes)
		countAgree = try values.decodeIfPresent(String.self, forKey: .countAgree)
		countNotAgree = try values.decodeIfPresent(String.self, forKey: .countNotAgree)
	}

}
