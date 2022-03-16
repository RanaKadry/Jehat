//
//  AppBarButtonType.swift
//  Jihat
//
//  Created by Peter Bassem on 21/09/2021.
//

import Foundation

@objc
enum AppBarButtonType: Int, RawRepresentable {
    case back
    case sidemenu
    
    public typealias RawValue = String
    
    var rawValue: RawValue {
        switch self {
        case .back: return "back"
        case .sidemenu: return "side-menu"
        }
    }
    
    init?(rawValue: RawValue) {
        switch rawValue {
        case "back": self = .back
        case "side-menu": self = .sidemenu
        default: return nil
        }
    }
}
