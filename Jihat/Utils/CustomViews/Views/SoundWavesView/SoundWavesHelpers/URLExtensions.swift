//
//  URLExtensions.swift
//  Recorder
//
//  Created by Peter Bassem on 07/10/2021.
//

import Foundation

extension URL {
    
    static func checkPath(_ path: String) -> Bool {
        let isFileExist = FileManager.default.fileExists(atPath: path)
        return isFileExist
    }
    
    static func documentsPath(forFileName fileName: String) -> URL? {
        let documents = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let writePath = URL(string: documents)!.appendingPathComponent(fileName)
        
        var directory: ObjCBool = ObjCBool(false)
        if FileManager.default.fileExists(atPath: documents, isDirectory:&directory) {
            return directory.boolValue ? writePath : nil
        }
        return nil
    }
}

// MARK: - URL to [URLQueryItem]

extension URL {
    func toQueryItems() -> [URLQueryItem]? { return URLComponents(url: self, resolvingAgainstBaseURL: false)?.queryItems }
}

// MARK: - create [URLQueryItem] from [AnyHashable: Any] or [any]

extension URLQueryItem {
    private static var _bracketsString: String { return "[]" }
    static func create(from values: [Any], with key: String) -> [URLQueryItem] {
        let _key = key.contains(_bracketsString) ? key : key + _bracketsString
        return values.compactMap { value -> URLQueryItem? in
            if value is [Any] || value is [AnyHashable: Any] { return nil }
            return URLQueryItem(name: _key, value: value as? String ?? "\(value)")
        }
    }

    static func create(from values: [AnyHashable: Any]) -> [URLQueryItem] {
        return values.flatMap { element -> [URLQueryItem] in
            if element.value is [AnyHashable: Any] { return [] }
            let key = element.key as? String ?? "String"
            if let values = element.value as? [Any] { return URLQueryItem.create(from: values, with: key) }
            return [URLQueryItem(name: key, value: element.value as? String ?? "\(element.value)")]
        }
    }
}
