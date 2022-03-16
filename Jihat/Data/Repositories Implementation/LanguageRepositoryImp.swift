//
//  LanguageRepositoryImp.swift
//  Jihat
//
//  Created by Peter Bassem on 11/12/2021.
//  Copyright © 2021 Jehat. All rights reserved.
//

import Foundation

class LanguageRepositoryImp: LanguageRepository {
    
    private let localLanguageDataSource = LocalLanguageDataSource()
    
    var getCurrentLanguage: String {
        return localLanguageDataSource.getCurrentLanguage
    }
    
    func updateLanguage(_ newLanguage: String) {
        localLanguageDataSource.updateLanguage(newLanguage)
    }
}
