//
//  Font.swift
//  Jihat
//
//  Created by Peter Bassem on 13/09/2021.
//

import Foundation
import UIKit

enum Font: String {
    case black = "Cairo-Black"
    case bold = "Cairo-Bold"
    case semiBold = "Cairo-SemiBold"
    case extraLight = "Cairo-ExtraLight"
    case light = "Cairo-Light"
    case regular = "Cairo-Regular"
    
    var name: String {
        return self.rawValue
    }
}
