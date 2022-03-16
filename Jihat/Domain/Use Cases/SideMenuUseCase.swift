//
//  SideMenuUseCase.swift
//  Jihat
//
//  Created by Peter Bassem on 08/02/2022.
//  Copyright © 2022 Jehat. All rights reserved.
//

import Foundation

class SideMenuUseCase {
    private let userRepository: UserRepository
    
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    // ------------
    // MARK: - USER
    // ------------
    var userToken: String? {
        return userRepository.userToken
    }
}
