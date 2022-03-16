//
//  UserAppointmentsRequest.swift
//  Jihat
//
//  Created by Peter Bassem on 13/11/2021.
//  Copyright © 2021 Jehat. All rights reserved.
//

import Foundation

struct UserAppointmentsRequest: Codable {
    let userToken: String?
    let pageNumber: String?
    let dateFrom: String?
    let dateTo: String?
    
    enum CodingKeys: String, CodingKey {
        case userToken = "Token"
        case pageNumber = "page_no"
        case dateFrom = "From"
        case dateTo = "To"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        userToken = try values.decodeIfPresent(String.self, forKey: .userToken)
        pageNumber = try values.decodeIfPresent(String.self, forKey: .pageNumber)
        dateFrom = try values.decodeIfPresent(String.self, forKey: .dateFrom)
        dateTo = try values.decodeIfPresent(String.self, forKey: .dateTo)
    }
    
    init(userToken: String?, pageNumber: String?, dateFrom: String?, dateTo: String?) {
        self.userToken = userToken
        self.pageNumber = pageNumber
        self.dateFrom = dateFrom
        self.dateTo = dateTo
    }
}
