//
//  ProfileUseCase.swift
//  Jihat
//
//  Created by Peter Bassem on 23/10/2021.
//

import Foundation

class ProfileUseCase {
    
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
    
    var userId: String? {
        return userRepository.userId
    }
    
    func getUser(userDataRequest: BaseRequest, completion: @escaping (Result<APIResponse<UserDataResponse>, NetworkErrorType>) -> Void) {
        userRepository.getUser(userDataRequest: userDataRequest, completion: completion)
    }
    
    func getUserCountries(completion: @escaping (Result<APIResponse<[CountriesModel]>, NetworkErrorType>) -> Void) {
        userRepository.getUserCountries(completion: completion)
    }
    
    func updateUser(updateUserDataRequest: UpdateUserDataRequest, completion: @escaping (Result<APIResponse<AuthModel>, NetworkErrorType>) -> Void) {
        userRepository.updateUser(updateUserDataRequest: updateUserDataRequest, completion: completion)
    }
}
