//
//  UserRepository.swift
//  Jihat
//
//  Created by Peter Bassem on 16/10/2021.
//

import Foundation

protocol UserRepository {
    func login(loginRequest: LoginRequest, completion: @escaping (Result<APIResponse<AuthModel>, NetworkErrorType>) -> Void)
    func resetPassword(forgetPasswordRequest: ForgetPasswordRequest, completion: @escaping (Result<APIResponse<AuthModel>, NetworkErrorType>) -> Void)
    func register(registerRequest: RegisterRequest, completion: @escaping (Result<APIResponse<AuthModel>, NetworkErrorType>) -> Void)
    func saveUserToken(_ token: String?)
    func saveUserId(_ id: String?)
    var userToken: String? { get }
    var userId: String? { get }
    var isUserLoggedIn: Bool { get }
    func getUserCountries(completion: @escaping (Result<APIResponse<[CountriesModel]>, NetworkErrorType>) -> Void)
    func setUserVerified(_ userVerified: Bool)
    var sendSMS: Bool { get }
    var isUserVerified: Bool { get }
    func updateSendSMS(_ sendSMS: Bool)
    func resendVerificationCode(resendVerificationCodeRequest: ResendVerifiyCodeRequest, completion: @escaping (Result<APIResponse<AuthModel>, NetworkErrorType>) -> Void)
    func submitVerificationCode(submitVerificationCodeRequest: VerifyCodeRequest, completion: @escaping (Result<APIResponse<AuthModel>, NetworkErrorType>) -> Void)
    
    func getUser(userDataRequest: BaseRequest, completion: @escaping (Result<APIResponse<UserDataResponse>, NetworkErrorType>) -> Void)
    func updateUser(updateUserDataRequest: UpdateUserDataRequest, completion: @escaping (Result<APIResponse<AuthModel>, NetworkErrorType>) -> Void)
    func logout(logoutRequest: BaseRequest, completion: @escaping (Result<APIResponse<AuthModel>, NetworkErrorType>) -> Void)
    func clearLocalData()
}
