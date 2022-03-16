//
//  HomeUseCase.swift
//  Jihat
//
//  Created by Peter Bassem on 22/10/2021.
//

import Foundation
import PromisedFuture

class HomeUseCase {
    
    private let userRepository: UserRepository
    private let orderRepository: OrderRepository
    private let meetingRepository: MeetingRepository
    private let appointmentRepository: AppointmentRepoistory
    private let languageRepository: LanguageRepository
    
    init(userRepository: UserRepository, orderRepository: OrderRepository, meetingRepository: MeetingRepository, appointmentRepository: AppointmentRepoistory, languageRepository: LanguageRepository) {
        self.userRepository = userRepository
        self.orderRepository = orderRepository
        self.meetingRepository = meetingRepository
        self.appointmentRepository = appointmentRepository
        self.languageRepository = languageRepository
    }
    
    // ------------
    // MARK: - USER
    // ------------
    var userToken: String? {
        return userRepository.userToken
    }
    
    func getUser(userDataRequest: BaseRequest, completion: @escaping (Result<APIResponse<UserDataResponse>, NetworkErrorType>) -> Void) {
        userRepository.getUser(userDataRequest: userDataRequest, completion: completion)
    }
    
    func logout(logoutRequest: BaseRequest, completion: @escaping (Result<APIResponse<AuthModel>, NetworkErrorType>) -> Void) {
        userRepository.logout(logoutRequest: logoutRequest, completion: completion)
    }
    
    func clearLocalData() {
        userRepository.clearLocalData()
    }
    
    // -------------
    // MARK: - ORDER
    // -------------
    func getUserOrders(userOrdersRequest: UserOrdersRequest, completion: @escaping (Result<APIResponse<[UserOrdersResponse]>, NetworkErrorType>) -> Void) {
        orderRepository.getUserOrders(userOrdersRequest: userOrdersRequest, completion: completion)
    }
    
    func getOrderFilterItems(completion: @escaping (Result<APIResponse<[TicketFilterItemsResponse]>, NetworkErrorType>) -> Void) {
        orderRepository.getOrderFilterItems(completion: completion)
    }
    
    // ---------------
    // MARK: - MEETING
    // ---------------
    func getUserMeetings(meetingsRequest: UserMeetingsRequest, completion: @escaping (Result<APIResponse<[UserMeetingsResponse]>, NetworkErrorType>) -> Void) {
        meetingRepository.getUserMeetings(meetingsRequest: meetingsRequest, completion: completion)
    }
    
    func getMeetingFilterItems(completion: @escaping (Result<APIResponse<[MeetingFilterItemsResponse]>, NetworkErrorType>) -> Void) {
        meetingRepository.getMeetingFilterItems(completion: completion)
    }
    
    // -------------------
    // MARK: - APPOINTMENT
    // -------------------
    func getUserAppointments(appointmentsRequest: UserAppointmentsRequest, completion: @escaping (Result<APIResponse<[UserAppointmentsResponse]>, NetworkErrorType>) -> Void) {
        appointmentRepository.getUserAppointments(appointmentsRequest: appointmentsRequest, completion: completion)
    }
    
    // ----------------
    // MARK: - LANGUAGE
    // ----------------
    var getCurrentLanguage: String {
        return languageRepository.getCurrentLanguage
    }
    
    func updateLanguage(_ newLanguage: String) {
        languageRepository.updateLanguage(newLanguage)
    }
}
