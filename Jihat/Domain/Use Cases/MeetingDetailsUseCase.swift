//
//  MeetingDetailsUseCase.swift
//  Jihat
//
//  Created by Peter Bassem on 06/12/2021.
//  Copyright © 2021 Jehat. All rights reserved.
//

import Foundation

class MeetingDetailsUseCase {
    private let userRepository: UserRepository
    private let meetingRepository: MeetingRepository
    
    init(userRepository: UserRepository, meetingRepository: MeetingRepository) {
        self.userRepository = userRepository
        self.meetingRepository = meetingRepository
    }
    
    // ------------
    // MARK: - USER
    // ------------
    var userToken: String? {
        return userRepository.userToken
    }
    
    // ---------------
    // MARK: - MEETING
    // ---------------
    func getMeetingDetails(userMeetingDetailsRequest: UserMeetingDetailsRequest, completion: @escaping (Result<APIResponse<UserMeetingDetailsResponse>, NetworkErrorType>) -> Void) {
        meetingRepository.getMeetingDetails(userMeetingDetailsRequest: userMeetingDetailsRequest, completion: completion)
    }
    
    func attendMeeting(attendMeetingRequest: UserMeetingDetailsRequest, completion: @escaping (Result<APIResponse<EmptyResponse>, NetworkErrorType>) -> Void) {
        meetingRepository.attendMeeting(attendMeetingRequest: attendMeetingRequest, completion: completion)
    }
    
    func getMeetingTerms(userMeetingDetailsRequest: UserMeetingDetailsRequest, completion: @escaping (Result<APIResponse<[UserMeetingTermsResponse]>, NetworkErrorType>) -> Void) {
        meetingRepository.getMeetingTerms(userMeetingDetailsRequest: userMeetingDetailsRequest, completion: completion)
    }
    
    func getMeetingCandidates(userMeetingCandidatesRequest: UserMeetingDetailsRequest, completion: @escaping (Result<APIResponse<UserMeetingCandidatesResponse>, NetworkErrorType>) -> Void) {
        meetingRepository.getMeetingCandidates(userMeetingCandidatesRequest: userMeetingCandidatesRequest, completion: completion)
    }
}
