//
//  Gender.swift
//  Jihat
//
//  Created by Peter Bassem on 16/10/2021.
//

import Foundation

enum Gender: Int, CaseIterable {
    case male = 0
    case female = 1
    
    var description: String {
        switch self {
        case .male: return "male"
        case .female: return "female"
        }
    }
}
