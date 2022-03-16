//
//  UserMeetingsRequest.swift
//  Jihat
//
//  Created by Peter Bassem on 20/11/2021.
//  Copyright © 2021 Jehat. All rights reserved.
//

import Foundation

struct UserMeetingsRequest: Codable {
    let userToken: String?
    let pageNumber: String?
    let filter: String?
    
    enum CodingKeys: String, CodingKey {
        case userToken = "Token"
        case pageNumber = "page_no"
        case filter
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        userToken = try values.decodeIfPresent(String.self, forKey: .userToken)
        pageNumber = try values.decodeIfPresent(String.self, forKey: .pageNumber)
        filter = try values.decodeIfPresent(String.self, forKey: .filter)
    }
    
    init(userToken: String?, pageNumber: String?, filter: String?) {
        self.userToken = userToken
        self.pageNumber = pageNumber
        self.filter = filter
    }
}
