//
//  CandidatesUseCase.swift
//  Jihat
//
//  Created by Peter Bassem on 13/12/2021.
//  Copyright © 2021 Jehat. All rights reserved.
//

import Foundation

class CandidatesUseCase {
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
    func voteMeetingCandidates(voteMeetingCandidate: UserMeetingDetailsRequest, bodyData: Data, completion: @escaping (Result<APIResponse<String>, NetworkErrorType>) -> Void) {
        meetingRepository.voteMeetingCandidates(voteMeetingCandidate: voteMeetingCandidate, bodyData: bodyData, completion: completion)
    }
    
    func voteMeetingCandidatesTypeTwo(voteMeetingCandidate: UserMeetingDetailsRequest, bodyData: Data, completion: @escaping (Result<APIResponse<String>, NetworkErrorType>) -> Void) {
        meetingRepository.voteMeetingCandidatesTypeTwo(voteMeetingCandidate: voteMeetingCandidate, bodyData: bodyData, completion: completion)
    }
    
    func voteMeetingCandidatesTypeThree(voteMeetingCandidate: UserMeetingDetailsRequest, bodyData: Data, completion: @escaping (Result<APIResponse<String>, NetworkErrorType>) -> Void) {
        meetingRepository.voteMeetingCandidatesTypeThree(voteMeetingCandidate: voteMeetingCandidate, bodyData: bodyData, completion: completion)
    }
}
