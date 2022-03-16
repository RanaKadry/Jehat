//
//  LoginUseCase.swift
//  Jihat
//
//  Created by Peter Bassem on 16/10/2021.
//

import Foundation

class LoginUseCase {
    
    private let sponsersRepository: SponserRepository
    private let userRepository: UserRepository
    
    init(sponsersRepository: SponserRepository, userRepository: UserRepository) {
        self.sponsersRepository = sponsersRepository
        self.userRepository = userRepository
    }

    // ----------------
    // MARK: - SPONSERS
    // ----------------
    func getSponsers(completion: @escaping (Result<APIResponse<[SponsersModel]>, NetworkErrorType>) -> Void) {
        sponsersRepository.getSponsers(completion: completion)
    }
    
    // ------------
    // MARK: - USER
    // ------------
    func login(withLoginRequest loginRequest: LoginRequest, completion: @escaping (Result<APIResponse<AuthModel>, NetworkErrorType>) -> Void) {
        userRepository.login(loginRequest: loginRequest, completion: completion)
    }
    
    func saveUserToken(token: String?) {
        userRepository.saveUserToken(token)
    }
    
    func saveUserId(id: String?) {
        userRepository.saveUserId(id)
    }
    
    var userToken: String? {
        return userRepository.userToken
    }
    
    var userId: String? {
        return userRepository.userId
    }
    
    var isLoggedIn: Bool {
        return userRepository.isUserLoggedIn
    }
}
