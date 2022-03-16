//
//  UserMeetingTermVoteRequest.swift
//  Jihat
//
//  Created by Peter Bassem on 10/12/2021.
//  Copyright © 2021 Jehat. All rights reserved.
//

import Foundation

struct UserMeetingTermVoteRequest: Codable {
    let userToken: String?
    let meetingId: String?
    let termId: String?
    let vote: String?
    let comment: String?
    
    enum CodingKeys: String, CodingKey {
        case userToken = "Token"
        case meetingId = "M_ID"
        case termId = "Term_ID"
        case vote = "Vote"
        case comment = "Comment"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        userToken = try values.decodeIfPresent(String.self, forKey: .userToken)
        meetingId = try values.decodeIfPresent(String.self, forKey: .meetingId)
        termId = try values.decodeIfPresent(String.self, forKey: .termId)
        vote = try values.decodeIfPresent(String.self, forKey: .vote)
        comment = try values.decodeIfPresent(String.self, forKey: .comment)
    }
    
    init(userToken: String?, meetingId: String?, termId: String?, vote: String?, comment: String?) {
        self.userToken = userToken
        self.meetingId = meetingId
        self.termId = termId
        self.vote = vote
        self.comment = comment
    }
}
