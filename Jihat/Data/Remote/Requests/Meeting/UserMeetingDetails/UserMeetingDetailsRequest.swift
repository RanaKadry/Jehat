//
//  UserMeetingDetailsRequest.swift
//  Jihat
//
//  Created by Peter Bassem on 06/12/2021.
//  Copyright © 2021 Jehat. All rights reserved.
//

import Foundation

struct UserMeetingDetailsRequest: Codable {
    let userToken: String?
    let meetingId: String?
    
    enum CodingKeys: String, CodingKey {
        case userToken = "Token"
        case meetingId = "M_ID"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        userToken = try values.decodeIfPresent(String.self, forKey: .userToken)
        meetingId = try values.decodeIfPresent(String.self, forKey: .meetingId)
    }
    
    init(userToken: String?, meetingId: String?) {
        self.userToken = userToken
        self.meetingId = meetingId
    }
}
