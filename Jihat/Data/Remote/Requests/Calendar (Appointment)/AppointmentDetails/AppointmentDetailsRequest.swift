//
//  AppointmentDetailsRequest.swift
//  Jihat
//
//  Created by Peter Bassem on 14/11/2021.
//  Copyright © 2021 Jehat. All rights reserved.
//

import Foundation

struct AppointmentDetailsRequest: Codable {
    let userToken: String?
    let appointmentId: String?
    
    enum CodingKeys: String, CodingKey {
        case userToken = "Token"
        case appointmentId = "ID"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        userToken = try values.decodeIfPresent(String.self, forKey: .userToken)
        appointmentId = try values.decodeIfPresent(String.self, forKey: .appointmentId)
    }
    
    init(userToken: String?, appointmentId: String?) {
        self.userToken = userToken
        self.appointmentId = appointmentId
    }
}
