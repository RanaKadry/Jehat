//
//  RegisterUseCase.swift
//  Jihat
//
//  Created by Peter Bassem on 16/10/2021.
//

import Foundation
import PromisedFuture

class RegisterUseCase {
    
    private let userRepository: UserRepository
    
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    // ------------
    // MARK: - USER
    // ------------
    func getUserCountries(completion: @escaping (Result<APIResponse<[CountriesModel]>, NetworkErrorType>) -> Void) {
        userRepository.getUserCountries(completion: completion)
    }
    
    func registerUser(registerRequest: RegisterRequest, completion: @escaping (Result<APIResponse<AuthModel>, NetworkErrorType>) -> Void) {
        userRepository.register(registerRequest: registerRequest, completion: completion)
    }
    
    func saveUserId(id: String?) {
        userRepository.saveUserId(id)
    }

    func update(userVerified: Bool) {
        userRepository.setUserVerified(userVerified)
    }
}
