//
//  RegisterTypes.swift
//  Jihat
//
//  Created by Peter Bassem on 18/09/2021.
//

import Foundation

enum RegisterTypes: Int, CaseIterable {
    case insideCountry
    case outsideCountry
    
    var description: String {
        switch self {
        case .insideCountry: return "inside_country"
        case .outsideCountry: return "outside_country"
        }
    }
}
