//
//  PersistentDataHelper.swift
//  Incadre
//
//  Created by Peter Bassem on 9/13/20.
//  Copyright © 2020 Peter Bassem. All rights reserved.
//

import Foundation

// MARK: - UserDefaultsKeys
enum UserDefaultsKeys: String {
    case token = "ACCESS_TOKEN"
    case id = "USER_ID"
    case sendSMS = "SEND_SMS"
    case accountVerified = "ACCOUNT_VERIFIED"
}

// MARK: - UserDefaults
let userDefaults = UserDefaults.standard

let encoder = JSONEncoder()
let decoder = JSONDecoder()

// MARK: -
class PersistentDataHelper {
    
    static let shared = PersistentDataHelper()
    
    private init() { }
    
    var token: String? {
        get { return userDefaults.string(forKey: UserDefaultsKeys.token.rawValue) }
        set { set(newValue, forKey: UserDefaultsKeys.token) }
    }
    
    var userId: String? {
        get { return userDefaults.string(forKey: UserDefaultsKeys.id.rawValue) }
        set { set(newValue, forKey: UserDefaultsKeys.id) }
    }
    
    var sendSMS: Bool {
        get { return userDefaults.bool(forKey: UserDefaultsKeys.sendSMS.rawValue) }
        set { set(newValue, forKey: UserDefaultsKeys.sendSMS) }
    }
    
    var accountVerified: Bool {
        get { return userDefaults.bool(forKey: UserDefaultsKeys.accountVerified.rawValue) }
        set { set(newValue, forKey: UserDefaultsKeys.accountVerified) }
    }
    
    // MARK: - Clear UserDefaults
    func clear() {
        let domain = Bundle.main.bundleIdentifier!
        userDefaults.removePersistentDomain(forName: domain)
        userDefaults.synchronize()
    }
}

extension PersistentDataHelper {
    
    func set<T: Codable>(_ value: T?, type: T.Type, forKey key: UserDefaultsKeys) {
        let encodedT = try? encoder.encode(value)
        userDefaults.set(encodedT, forKey: key.rawValue)
    }
    
    func set(_ value: Any?, forKey key: UserDefaultsKeys) {
        userDefaults.set(value, forKey: key.rawValue)
    }
    
    func get<T: Codable>(forKey key: UserDefaultsKeys, withType type: T.Type) -> T? {
        guard let savedEncodedObject = userDefaults.object(forKey: key.rawValue) as? Data else { return nil }
        return try? decoder.decode(T.self, from: savedEncodedObject)
    }
}
