//
//  LanguageRepository.swift
//  Jihat
//
//  Created by Peter Bassem on 11/12/2021.
//  Copyright © 2021 Jehat. All rights reserved.
//

import Foundation

protocol LanguageRepository {
    var getCurrentLanguage: String { get }
    func updateLanguage(_ newLanguage: String)
}
