//
//  AppDelegateExtensions.swift
//  Driver
//
//  Created by Peter Bassem on 26/12/2020.
//  Copyright © 2020 Eslam Maged. All rights reserved.
//

import Foundation
import IQKeyboardManagerSwift

extension AppDelegate {
    
    func setupIQKeyboard() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.placeholderFont = DesignSystem.Typography.paragraphSmall.font
        IQKeyboardManager.shared.toolbarTintColor = .gray
        UIToolbar.appearance().tintColor = .lightGray
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        IQKeyboardManager.shared.keyboardDistanceFromTextField = 20
        IQKeyboardManager.shared.toolbarDoneBarButtonItemText = "done".localized()
    }
}

class IQKeyboardManagerHelper {
    
    class func setDoneTitle() {
        IQKeyboardManager.shared.toolbarDoneBarButtonItemText = "done".localized()
    }
}
