//
//  Colors.swift
//  Jihat
//
//  Created by Peter Bassem on 13/09/2021.
//

import Foundation
import UIKit

extension DesignSystem {
    
    enum Colors: String {
        case primary = "Primary"
        case primaryActionText = "PrimaryActionText"
        case primaryActionBackground = "PrimaryActionBackground"
        case primaryGradient = "PrimaryGradient"
        case secondaryGradient = "SecondaryGradient"
        case textPlaceholder = "TextPlaceholderColor"
        case textPrimary = "TextPrimary"
        case primaryBorderColor = "PrimaryBorderColor"
        case secondaryBorderColor = "SecondaryBorderColor"
        case primaryShadow = "PrimaryShadow"
        case text1Color = "Text1Color"
        case text2Color = "Text2Color"
        case text3Color = "Text3Color"
        case text4Color = "Text4Color"
        case text6Color = "Text6Color"
        case background3Color = "Background3Color"
        case primaryActionColor = "PrimaryActionColor"
        case action3Color = "Action3Color"
        case backgroundSecondaryColor = "BackgroundSecondaryColor"
        case backgroundTransparentColor = "BackgroundTransparentColor"
        
        var color: UIColor {
            return UIColor(named: self.rawValue)!
        }
    }
}
