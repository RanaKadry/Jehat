//
//  HomeInteractor.swift
//  Jihat
//
//  Created Peter Bassem on 21/09/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

// MARK: Home Interactor -

class HomeInteractor: HomeInteractorInputProtocol {
    
    weak var presenter: HomeInteractorOutputProtocol?
    private var useCase: HomeUseCase
    
    private var user: UserDataResponse?
    private var orders: [UserOrdersResponse]?
    private var meetings: [UserMeetingsResponse]?
    private var appointments: [UserAppointmentsResponse]?
    private var error: String?
    
    init(useCase: HomeUseCase) {
        self.useCase = useCase
    }
    
    var userToken: String? {
        return useCase.userToken
    }
    
    private func getUser(userRequest: BaseRequest, successCompletion: @escaping (UserDataResponse) -> Void, faillCompletion: @escaping (String) -> Void) {
        useCase.getUser(userDataRequest: userRequest) { result in
            switch result {
            case .success(let userResponse):
                if userResponse.status == true {
                    guard let user = userResponse.data else { return }
                    successCompletion(user)
                } else {
                    faillCompletion(userResponse.message ?? "")
                }
            case .failure(let error):
                faillCompletion(error.rawValue.localized())
            }
        }
    }
    
    private func getUserOrders(userOrdersRequest: UserOrdersRequest, successCompletion: @escaping ([UserOrdersResponse]) -> Void, failCompletion: @escaping (String) -> Void) {
        useCase.getUserOrders(userOrdersRequest: userOrdersRequest) { result in
            switch result {
            case .success(let userOrdersResponse):
                if userOrdersResponse.status == true {
                    guard let orders = userOrdersResponse.data else { return }
                    successCompletion(orders)
                } else {
                    failCompletion(userOrdersResponse.message ?? "")
                }
            case .failure(let error):
                failCompletion(error.rawValue.localized())
            }
        }
    }
    
    private func getUserMeetings(meetingsRequest: UserMeetingsRequest, successCompletion: @escaping ([UserMeetingsResponse]) -> Void, failCompletion: @escaping (String) -> Void) {
        useCase.getUserMeetings(meetingsRequest: meetingsRequest) { result in
            switch result {
            case .success(let userMeetingsResponse):
                if userMeetingsResponse.status == true {
                    guard let meetings = userMeetingsResponse.data else { return }
                    successCompletion(meetings)
                } else {
                    failCompletion(userMeetingsResponse.message ?? "")
                }
            case .failure(let error):
                failCompletion(error.rawValue.localized())
            }
        }
    }
    
    private func getUserAppointments(appointmentsRequest: UserAppointmentsRequest, successCompletion: @escaping ([UserAppointmentsResponse]) -> Void, failCompletion: @escaping (String) -> Void) {
        useCase.getUserAppointments(appointmentsRequest: appointmentsRequest) { result in
            switch result {
            case.success(let userAppointmentsResponse):
                if userAppointmentsResponse.status == true {
                    guard let appointments = userAppointmentsResponse.data else { return }
                    successCompletion(appointments)
                } else {
                    failCompletion(userAppointmentsResponse.message ?? "")
                }
            case .failure(let error):
                failCompletion(error.rawValue.localized())
            }
        }
    }
    
    func getHomeData(homeRequest: BaseRequest, userOrdersRequest: UserOrdersRequest, meetingsRequest: UserMeetingsRequest, appointmentsRequest: UserAppointmentsRequest) {
        let dispatchGroup = DispatchGroup()
        
        if userToken != nil {
            dispatchGroup.enter()
            getUser(userRequest: homeRequest) { [weak self] user in
                dispatchGroup.leave()
                self?.user = user
            } faillCompletion: { [weak self] error in
                dispatchGroup.leave()
                self?.error = error
            }
        }
        
        dispatchGroup.enter()
        getUserOrders(userOrdersRequest: userOrdersRequest) { [weak self] orders in
            dispatchGroup.leave()
            self?.orders = orders
        } failCompletion: { [weak self] error in
            dispatchGroup.leave()
            self?.error = error
        }
        
        dispatchGroup.enter()
        getUserMeetings(meetingsRequest: meetingsRequest) { [weak self] meetings in
            dispatchGroup.leave()
            self?.meetings = meetings
        } failCompletion: { [weak self] error in
            dispatchGroup.leave()
            self?.error = error
        }

        dispatchGroup.enter()
        getUserAppointments(appointmentsRequest: appointmentsRequest) { [weak self] appointments in
            dispatchGroup.leave()
            self?.appointments = appointments
        } failCompletion: { [weak self] error in
            dispatchGroup.leave()
            self?.error = error
        }

        dispatchGroup.notify(queue: .main) { [weak self] in
            if let error = self?.error {
                self?.presenter?.fetchingWithError(error: error)
            }
            if self?.userToken != nil {
                if let user = self?.user {
                    self?.presenter?.fetchingHomeItemsWithSuccess(user: user)
                }
            } else {
                self?.presenter?.fetchingGuestHomeItemsWithSuccess()
            }
            if let orders = self?.orders {
                if orders.isEmpty {
                    self?.presenter?.fetchingEmptyUserOrdersWithSuccess()
                } else {
                    self?.presenter?.fetchingUserOrdersWithSuccess(orders: orders)
                }
            }
            if let meetings = self?.meetings {
                if meetings.isEmpty {
                    self?.presenter?.fetchingEmptyUserMeetingsWithSuccess()
                } else {
                    self?.presenter?.fetchingUserMeetingsWithSuccess(meetings: meetings)
                }
            }
            if let appointments = self?.appointments {
                if appointments.isEmpty {
                    self?.presenter?.fetchingEmptyUserAppointmentsWithSuccess()
                } else {
                    self?.presenter?.fetchingUserAppointmentsWithSuccess(appointments: appointments)
                }
            }
        }
    }
    
    func getOrderFilterItems() {
        useCase.getOrderFilterItems { [weak self] result in
            switch result {
            case .success(let orderFilterItemsResponse):
                guard let orderFilterItems = orderFilterItemsResponse.data, !orderFilterItems.isEmpty else { return }
                DispatchQueue.main.async {
                    self?.presenter?.fetchingOrderFilterItems(orderFilterItems: orderFilterItems)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.presenter?.fetchingWithError(error: error.rawValue.localized())
                }
            }
        }
    }
    
    func updateUserOrders(userOrdersRequest: UserOrdersRequest, isFiltering: Bool) {
        useCase.getUserOrders(userOrdersRequest: userOrdersRequest) { [weak self] result in
            switch result {
            case .success(let userOrdersResponse):
                if userOrdersResponse.status == true {
                    guard let orders = userOrdersResponse.data, !orders.isEmpty else {
                        guard !isFiltering else {
                            DispatchQueue.main.async { [weak self] in
                                self?.presenter?.fetchingEmptyUserOrdersWithSuccess()
                            }
                            return
                        }
                        return
                    }
                    DispatchQueue.main.async {
                        self?.presenter?.fetchingUserOrdersWithSuccess(orders: orders)
                    }
                } else {
                    DispatchQueue.main.async { [weak self] in
                        self?.presenter?.fetchingWithError(error: userOrdersResponse.message ?? "")
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async { [weak self] in
                    self?.presenter?.fetchingWithError(error: error.rawValue.localized())
                }
            }
        }
    }
    
    func getMeetingFilterItems() {
        useCase.getMeetingFilterItems { [weak self] result in
            switch result {
            case .success(let meetingFilterItemsResponse):
                guard let meetingFilterItems = meetingFilterItemsResponse.data, !meetingFilterItems.isEmpty else { return }
                DispatchQueue.main.async {
                    self?.presenter?.fetchingMeetingFilterItems(meetingFilterItems: meetingFilterItems)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.presenter?.fetchingWithError(error: error.rawValue.localized())
                }
            }
        }
    }
    
    func updateUserMeetings(userMeetingsRequest: UserMeetingsRequest, isFiltering: Bool) {
        useCase.getUserMeetings(meetingsRequest: userMeetingsRequest) { [weak self] result in
            switch result {
            case .success(let userMeetingsResponse):
                if userMeetingsResponse.status == true {
                    guard let meetings = userMeetingsResponse.data, !meetings.isEmpty else {
                        guard !isFiltering else {
                            DispatchQueue.main.async { [weak self] in
                                self?.presenter?.fetchingEmptyUserMeetingsWithSuccess()
                            }
                            return
                        }
                        return
                    }
                    DispatchQueue.main.async {
                        self?.presenter?.fetchingUserMeetingsWithSuccess(meetings: meetings)
                    }
                } else {
                    DispatchQueue.main.async { [weak self] in
                        self?.presenter?.fetchingWithError(error: userMeetingsResponse.message ?? "")
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async { [weak self] in
                    self?.presenter?.fetchingWithError(error: error.rawValue.localized())
                }
            }
        }
    }
    
    func updateUserAppointments(appointmentsRequest: UserAppointmentsRequest, isFiltering: Bool) {
        useCase.getUserAppointments(appointmentsRequest: appointmentsRequest) { [weak self] result in
            switch result {
            case.success(let userAppointmentsResponse):
                if userAppointmentsResponse.status == true {
                    guard let appointments = userAppointmentsResponse.data, !appointments.isEmpty else {
                        guard !isFiltering else {
                            DispatchQueue.main.async { [weak self] in
                                self?.presenter?.fetchingEmptyUserAppointmentsWithSuccess()
                            }
                            return
                        }
                        return
                    }
                    DispatchQueue.main.async {
                        self?.presenter?.fetchingUserAppointmentsWithSuccess(appointments: appointments)
                    }
                } else {
                    DispatchQueue.main.async { [weak self] in
                        self?.presenter?.fetchingWithError(error: userAppointmentsResponse.message ?? "")
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async { [weak self] in
                    self?.presenter?.fetchingWithError(error: error.rawValue.localized())
                }
            }
        }
    }
    
    func logoutUser(_ logoutRequest: BaseRequest) {
        useCase.logout(logoutRequest: logoutRequest) { result in
            switch result {
            case .success(let logoutResponse):
                if logoutResponse.status == true {
                    DispatchQueue.main.async { [weak self] in
                        self?.presenter?.fetchingLogoutWithSuccess()
                    }
                } else {
                    DispatchQueue.main.async { [weak self] in
                        self?.presenter?.fetchingWithError(error: logoutResponse.message ?? "")
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async { [weak self] in
                    self?.presenter?.fetchingWithError(error: error.rawValue.localized())
                }
            }
        }
    }
    
    var getCurrentLanguage: String {
        return useCase.getCurrentLanguage
    }
    
    func updateLanguage(_ newLanguage: String) {
        useCase.updateLanguage(newLanguage)
    }
    
    func clearLocalData() {
        useCase.clearLocalData()
    }
}
