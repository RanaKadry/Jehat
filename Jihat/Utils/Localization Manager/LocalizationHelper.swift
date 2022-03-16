//
//  LocalizationHelper.swift
//  SelfService
//
//  Created by Imac on 7/9/20.
//  Copyright © 2020 IbnSinai. All rights reserved.
//

import UIKit
import NaturalLanguage

class LocalizationHelper {
    // MARK: - variables

    class func isArabic() -> Bool {
        return getCurrentLanguage() == LanguageConstants.arabicLanguage.rawValue
    }
}

// MARK: - set Views Semantics

extension LocalizationHelper {
    fileprivate class func setViewsSemantics() {
        if LocalizationHelper.isArabic() {
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
            UIButton.appearance().semanticContentAttribute = .forceRightToLeft
            UITextView.appearance().semanticContentAttribute = .forceRightToLeft
            UITextField.appearance().semanticContentAttribute = .forceRightToLeft
            UILabel.appearance().semanticContentAttribute = .forceRightToLeft
            UICollectionViewCell.appearance().semanticContentAttribute = .forceRightToLeft
            UICollectionView.appearance().semanticContentAttribute = .forceRightToLeft
            UITableViewCell.appearance().semanticContentAttribute = .forceRightToLeft
            UITableView.appearance().semanticContentAttribute = .forceRightToLeft
        } else {
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
            UIButton.appearance().semanticContentAttribute = .forceLeftToRight
            UITextView.appearance().semanticContentAttribute = .forceLeftToRight
            UITextField.appearance().semanticContentAttribute = .forceLeftToRight
            UILabel.appearance().semanticContentAttribute = .forceLeftToRight
            UICollectionViewCell.appearance().semanticContentAttribute = .forceLeftToRight
            UICollectionView.appearance().semanticContentAttribute = .forceLeftToRight
            UITableViewCell.appearance().semanticContentAttribute = .forceLeftToRight
            UITableView.appearance().semanticContentAttribute = .forceLeftToRight
        }
    }
}

// MARK: - reset

extension LocalizationHelper {
    class func reset() {
        if #available(iOS 13.0, *) {
            sceneDelegate?.setRoot()
        } else {
            appDelegate?.setRoot()
        }
    }
    
    class func isSameAsPrefered() -> Bool {
        return Locale.current.languageCode == LocalizationHelper.getCurrentLanguage()
    }
}

// MARK: - set Current Lang

extension LocalizationHelper {
    class func setCurrentLang(lang: String) {
        let userdef = UserDefaults.standard
        userdef.set([lang], forKey: LanguageConstants.appleLanguage.rawValue)
        userdef.synchronize()
        LocalizationHelper.setViewsSemantics()
        LocalizationHelper.reset()
    }
}

// MARK: - get Current Language

extension LocalizationHelper {
    class func getCurrentLanguage() -> String {
        let userdef = UserDefaults.standard
        let langArray = userdef.object(forKey: LanguageConstants.appleLanguage.rawValue) as? NSArray
        let current = langArray?.firstObject as? String
        if let current = current {
            let currentWithoutLocale = String(current[..<current.index(current.startIndex, offsetBy: 2)])
            return currentWithoutLocale
        }
        return LanguageConstants.englishLanguage.rawValue
    }
    
    class func detectedLanguage(for string: String) -> String? {
        let recognizer = NLLanguageRecognizer()
        recognizer.processString(string)
        guard let languageCode = recognizer.dominantLanguage?.rawValue else { return nil }
        let detectedLanguage = Locale.current.localizedString(forIdentifier: languageCode)
        return detectedLanguage
    }
}

enum LanguageConstants: String {
    case appleLanguage = "AppleLanguages"
    case englishLanguage = "en"
    case arabicLanguage = "ar"
}
