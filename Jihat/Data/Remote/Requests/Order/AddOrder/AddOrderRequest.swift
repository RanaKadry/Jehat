//
//  AddOrderRequest.swift
//  Jihat
//
//  Created by Peter Bassem on 01/12/2021.
//  Copyright © 2021 Jehat. All rights reserved.
//

import Foundation

struct AddOrderRequest: Codable {
    let userToken: String?
    let departmentId: String?
    let transactionId: String?
    let topic: String?
    let orderDetails: String?
    let orderPriorityId: String?
    
    enum CodingKeys: String, CodingKey {
        case userToken = "Token"
        case departmentId = "Dep_ID"
        case transactionId = "Trans_ID"
        case topic = "Subject"
        case orderDetails = "Details"
        case orderPriorityId = "Priority"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        userToken = try values.decodeIfPresent(String.self, forKey: .userToken)
        departmentId = try values.decodeIfPresent(String.self, forKey: .departmentId)
        transactionId = try values.decodeIfPresent(String.self, forKey: .transactionId)
        topic = try values.decodeIfPresent(String.self, forKey: .topic)
        orderDetails = try values.decodeIfPresent(String.self, forKey: .orderDetails)
        orderPriorityId = try values.decodeIfPresent(String.self, forKey: .orderPriorityId)
    }
    
    init(userToken: String?, departmentId: String?, transactionId: String?, topic: String?, orderDetails: String?, orderPriorityId: String?) {
        self.userToken = userToken
        self.departmentId = departmentId
        self.transactionId = transactionId
        self.topic = topic
        self.orderDetails = orderDetails
        self.orderPriorityId = orderPriorityId
    }
}
