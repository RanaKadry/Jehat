//
//  UserMeetingDetailsInteractor.swift
//  Jihat
//
//  Created by Peter Bassem on 05/12/2021.
//  Copyright © 2021 Jehat. All rights reserved.
//
//

import Foundation

// MARK: UserMeetingDetails Interactor -

class UserMeetingDetailsInteractor: UserMeetingDetailsInteractorInputProtocol {
    
    weak var presenter: UserMeetingDetailsInteractorOutputProtocol?
    private let useCase: MeetingDetailsUseCase
    
    private var meetingDetails: UserMeetingDetailsResponse?
    private var meetingTemrs: [UserMeetingTermsResponse]?
    private var meetingCandidates: UserMeetingCandidatesResponse?
    private var error: String?
    
    init(useCase: MeetingDetailsUseCase) {
        self.useCase = useCase
    }
    
    var userToken: String? {
        return useCase.userToken
    }
    
    private func getMeetingDetails(userMeetingDetailsRequest: UserMeetingDetailsRequest, successCompletion: @escaping (UserMeetingDetailsResponse) -> Void, failCompletion: @escaping (String) -> Void) {
        useCase.getMeetingDetails(userMeetingDetailsRequest: userMeetingDetailsRequest) { result in
            switch result {
            case .success(let userMeetingDetailsResponse):
                if userMeetingDetailsResponse.status == true {
                    guard let details = userMeetingDetailsResponse.data else { return }
                    successCompletion(details)
                } else {
                    failCompletion(userMeetingDetailsResponse.message ?? "")
                }
            case .failure(let error):
                failCompletion(error.rawValue.localized())
            }
        }
    }
    
    func getMeetingTerms(userMeetingDetailsRequest: UserMeetingDetailsRequest, successCompletion: @escaping ([UserMeetingTermsResponse]) -> Void, failCompletion: @escaping (String) -> Void) {
        useCase.getMeetingTerms(userMeetingDetailsRequest: userMeetingDetailsRequest) { result in
            switch result {
            case .success(let userMeetingTermsResponse):
                if userMeetingTermsResponse.status == true {
                    guard let terms = userMeetingTermsResponse.data, !terms.isEmpty else { return }
                    successCompletion(terms)
                } else {
                    failCompletion(userMeetingTermsResponse.message ?? "")
                }
            case .failure(let error):
                failCompletion(error.rawValue.localized())
            }
        }
    }
    
    func getMeetingCandidates(userMeetingCandidatesRequest: UserMeetingDetailsRequest, successCompletion: @escaping (UserMeetingCandidatesResponse) -> Void, failCompletion: @escaping (String) -> Void) {
        useCase.getMeetingCandidates(userMeetingCandidatesRequest: userMeetingCandidatesRequest) { result in
            switch result {
            case .success(let userMeetingCandidatesResponse):
                if userMeetingCandidatesResponse.status == true {
                    guard let candidates = userMeetingCandidatesResponse.data else { return }
                    successCompletion(candidates)
                }
            case .failure(let error):
                failCompletion(error.rawValue.localized())
            }
        }
    }
    
    func getMeetingDetailsData(userMeetingDetailsRequest: UserMeetingDetailsRequest) {
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        getMeetingDetails(userMeetingDetailsRequest: userMeetingDetailsRequest) { [weak self] meetingDetails in
            dispatchGroup.leave()
            self?.meetingDetails = meetingDetails
        } failCompletion: { [weak self] error in
            dispatchGroup.leave()
            self?.error = error
        }
        
        dispatchGroup.enter()
        getMeetingTerms(userMeetingDetailsRequest: userMeetingDetailsRequest) { [weak self] meetingTemrs in
            dispatchGroup.leave()
            self?.meetingTemrs = meetingTemrs
        } failCompletion: { [weak self] error in
            dispatchGroup.leave()
            self?.error = error
        }
        
        dispatchGroup.enter()
        getMeetingCandidates(userMeetingCandidatesRequest: userMeetingDetailsRequest) { [weak self] meetingCandidates in
            dispatchGroup.leave()
            self?.meetingCandidates = meetingCandidates
        } failCompletion: { [weak self] error in
            dispatchGroup.leave()
            self?.error = error
        }

        dispatchGroup.notify(queue: .main) { [unowned self] in
            if let error = self.error {
                self.presenter?.fetchingWithError(error: error)
            }
            if let meetingDetails = self.meetingDetails {
                self.presenter?.fetchingMeetingDetailsWithSuccess(meetingDetails: meetingDetails)
            }
            if let meetingTemrs = self.meetingTemrs {
                self.presenter?.fetchingMeetingTermsWithSuccess(meetingTerms: meetingTemrs)
            }
            if let meetingCandidates = self.meetingCandidates {
                if meetingDetails?.candidatesFlag != "0" {
                    self.presenter?.fetchingMeetingCandidatesWithSuccess(meetingCandidates: meetingCandidates)
                }
            }
            self.presenter?.finishFetchingMeetingDetailsData()
        }
    }
    
    func attendMeeting(attendMeetingRequest: UserMeetingDetailsRequest) {
        useCase.attendMeeting(attendMeetingRequest: attendMeetingRequest) { [weak self] result in
            switch result {
            case .success(let attendMeetingResponse):
                if attendMeetingResponse.status == true {
                    DispatchQueue.main.async {
                        self?.presenter?.fetchingAttendMeetingWithSuccess()
                    }
                } else {
                    DispatchQueue.main.async {
                        self?.presenter?.fetchingWithError(error: attendMeetingResponse.message ?? "")
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.presenter?.fetchingWithError(error: error.rawValue.localized())
                }
            }
        }
    }
    
    
    func getMeetingTermsUpdates(userMeetingDetailsRequest: UserMeetingDetailsRequest) {
        useCase.getMeetingTerms(userMeetingDetailsRequest: userMeetingDetailsRequest) { [weak self] result in
            switch result {
            case .success(let userMeetingTermsResponse):
                if userMeetingTermsResponse.status == true {
                    guard let terms = userMeetingTermsResponse.data, !terms.isEmpty else { return }
                    DispatchQueue.main.async {
                        self?.presenter?.fetchingMeetingTermsUpdatesWithSuccess(meetingTerms: terms)
                    }
                } else {
                    DispatchQueue.main.async {
                        self?.presenter?.fetchingWithError(error: userMeetingTermsResponse.message ?? "")
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.presenter?.fetchingWithError(error: error.rawValue.localized())
                }
            }
        }
    }
}
