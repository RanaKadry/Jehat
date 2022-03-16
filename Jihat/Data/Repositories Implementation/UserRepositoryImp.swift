//
//  UserRepositoryImp.swift
//  Jihat
//
//  Created by Peter Bassem on 16/10/2021.
//

import Foundation

class UserRepositoryImp: UserRepository {
    
    private let remoteUserDataSource = RemoteUserDataSource()
    private let localUserDataSource = LocalUserDataSource()
    
    func login(loginRequest: LoginRequest, completion: @escaping (Result<APIResponse<AuthModel>, NetworkErrorType>) -> Void) {
        remoteUserDataSource.login(from: .login(loginRequset: loginRequest), completion: completion)
    }
    
    func resetPassword(forgetPasswordRequest: ForgetPasswordRequest, completion: @escaping (Result<APIResponse<AuthModel>, NetworkErrorType>) -> Void) {
        remoteUserDataSource.resetPassword(from: .resetPassword(forgetPasswordRequest: forgetPasswordRequest), completion: completion)
    }
    
    func register(registerRequest: RegisterRequest, completion: @escaping (Result<APIResponse<AuthModel>, NetworkErrorType>) -> Void) {
        remoteUserDataSource.register(from: .registerUser(registerRequest: registerRequest), completion: completion)
    }
    
    func saveUserToken(_ token: String?) {
        localUserDataSource.saveUser(token: token)
    }
    
    func saveUserId(_ id: String?) {
        localUserDataSource.saveUser(id: id)
    }
    
    var userToken: String? {
        return localUserDataSource.getUserToken()
    }
    
    var userId: String? {
        return localUserDataSource.getUserId()
    }
    
    var isUserLoggedIn: Bool {
        return localUserDataSource.getUserToken() != nil && localUserDataSource.getUserToken() != ""
    }
    
    func getUserCountries(completion: @escaping (Result<APIResponse<[CountriesModel]>, NetworkErrorType>) -> Void) {
        remoteUserDataSource.getUserCountires(from: .getUserCountries, completion: completion)
    }
    
    func setUserVerified(_ userVerified: Bool) {
        localUserDataSource.updatedVerificationState(state: userVerified)
    }
    
    var sendSMS: Bool {
        return localUserDataSource.sendSMS
    }
    
    func updateSendSMS(_ sendSMS: Bool) {
        localUserDataSource.updateSendSMS(sendSMS)
    }
    
    func resendVerificationCode(resendVerificationCodeRequest: ResendVerifiyCodeRequest, completion: @escaping (Result<APIResponse<AuthModel>, NetworkErrorType>) -> Void) {
        remoteUserDataSource.resendVerificationCode(from: .resendVerificationCode(resendVerificationCodeRequest: resendVerificationCodeRequest), completion: completion)
    }
    
    func submitVerificationCode(submitVerificationCodeRequest: VerifyCodeRequest, completion: @escaping (Result<APIResponse<AuthModel>, NetworkErrorType>) -> Void) {
        remoteUserDataSource.submitVerificationCode(from: .sendVerificationCode(verificationCodeRequest: submitVerificationCodeRequest), completion: completion)
    }
    
    var isUserVerified: Bool {
        return localUserDataSource.userVerificationState
    }
    
    func getUser(userDataRequest: BaseRequest, completion: @escaping (Result<APIResponse<UserDataResponse>, NetworkErrorType>) -> Void) {
        remoteUserDataSource.getUser(from: .getUserData(userDataRequest: userDataRequest), completion: completion)
    }
    
    func updateUser(updateUserDataRequest: UpdateUserDataRequest, completion: @escaping (Result<APIResponse<AuthModel>, NetworkErrorType>) -> Void) {
        remoteUserDataSource.updateUser(from: .updateUserData(updateUserDataRequest: updateUserDataRequest), completion: completion)
    }
    
    func logout(logoutRequest: BaseRequest, completion: @escaping (Result<APIResponse<AuthModel>, NetworkErrorType>) -> Void) {
        remoteUserDataSource.logoutUser(from: .logout(logoutRequest: logoutRequest), completion: completion)
    }
    
    func clearLocalData() {
        localUserDataSource.clearUserDefaults()
    }
}
