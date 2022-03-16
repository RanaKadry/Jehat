//
//  AddOrderBodyRequest.swift
//  Jihat
//
//  Created by Peter Bassem on 08/12/2021.
//  Copyright © 2021 Jehat. All rights reserved.
//

import Foundation

struct AddOrderBodyRequest: Codable {
    let propertyId: String?
    let propertyValues: [String]?
    
    enum CodingKeys: String, CodingKey {
        case propertyId = "Prop_ID"
        case propertyValues = "Prop_Sel_Val"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        propertyId = try values.decodeIfPresent(String.self, forKey: .propertyId)
        propertyValues = try values.decodeIfPresent([String].self, forKey: .propertyValues)
    }
    
    init(propertyId: String?, propertyValues: [String]?) {
        self.propertyId = propertyId
        self.propertyValues = propertyValues
    }
}
