//
//  LocalLanguageDataSource.swift
//  Jihat
//
//  Created by Peter Bassem on 11/12/2021.
//  Copyright © 2021 Jehat. All rights reserved.
//

import Foundation

class LocalLanguageDataSource {
    
    var getCurrentLanguage: String {
        LocalizationHelper.getCurrentLanguage()
    }
    
    func updateLanguage(_ newLanguage: String) {
        LocalizationHelper.setCurrentLang(lang: newLanguage)
    }
}
