//
//  LocalUserDataSource.swift
//  Jihat
//
//  Created by Peter Bassem on 16/10/2021.
//

import Foundation

class LocalUserDataSource {
    
    func saveUser(token: String?) {
        PersistentDataHelper.shared.token = token
    }
    
    func saveUser(id: String?) {
        PersistentDataHelper.shared.userId = id
    }
    
    func getUserToken() -> String? {
        return PersistentDataHelper.shared.token
    }
    
    func getUserId() -> String? {
        return PersistentDataHelper.shared.userId
    }
    
    func updatedVerificationState(state: Bool) {
        PersistentDataHelper.shared.accountVerified = state
        print("UserVerified value updaed:", PersistentDataHelper.shared.accountVerified)
    }
    
    var sendSMS: Bool {
        return PersistentDataHelper.shared.sendSMS
    }
    
    func updateSendSMS(_ sendSMS: Bool) {
        PersistentDataHelper.shared.sendSMS = sendSMS
    }
    
    var userVerificationState: Bool {
        return PersistentDataHelper.shared.accountVerified
    }
    
    func clearUserDefaults() {
        PersistentDataHelper.shared.clear()
    }
}
