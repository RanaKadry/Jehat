//
//  AddAppointmentRequest.swift
//  Jihat
//
//  Created by Peter Bassem on 24/11/2021.
//  Copyright © 2021 Jehat. All rights reserved.
//

import Foundation

struct AddAppointmentRequest: Codable {
    let userToken: String?
    let subject: String?
    let description: String?
    let data: String?
    let time: String?
    let alertType: String?
    
    enum CodingKeys: String, CodingKey {
        case userToken = "Token"
        case subject = "Subject"
        case description = "Discription"
        case data = "Date"
        case time = "Time"
        case alertType = "Type"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        userToken = try values.decodeIfPresent(String.self, forKey: .userToken)
        subject = try values.decodeIfPresent(String.self, forKey: .subject)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        data = try values.decodeIfPresent(String.self, forKey: .data)
        time = try values.decodeIfPresent(String.self, forKey: .time)
        alertType = try values.decodeIfPresent(String.self, forKey: .alertType)
    }
    
    init(userToken: String?, subject: String?, description: String?, data: String?, time: String?, alertType: String?) {
        self.userToken = userToken
        self.subject = subject
        self.description = description
        self.data = data
        self.time = time
        self.alertType = alertType
    }
}
