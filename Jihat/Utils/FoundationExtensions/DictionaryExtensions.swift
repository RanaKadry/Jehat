//
//  DictionaryExtensions.swift
//  Jihat
//
//  Created by Peter Bassem on 22/10/2021.
//

import Foundation

// MARK: - [AnyHashable: Any] to [URLQueryItem]

extension Dictionary where Value: Any {
   func toURLQueryItems() -> [URLQueryItem] { return URLQueryItem.create(from: self) }
}
