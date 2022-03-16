//
//  VoteMeetingTermUseCase.swift
//  Jihat
//
//  Created by Peter Bassem on 10/12/2021.
//  Copyright © 2021 Jehat. All rights reserved.
//

import Foundation

class VoteMeetingTermUseCase {
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
    func voteMeetingTerm(userMeetingTermVoteRequest: UserMeetingTermVoteRequest, attachments: [String: [Data]], images: [Data], completion: @escaping (Result<APIResponse<String>, NetworkErrorType>) -> Void) {
        meetingRepository.voteMeetingTerm(userMeetingTermVoteRequest: userMeetingTermVoteRequest, attachments: attachments, images: images, completion: completion)
    }
    
    func editVoteMeetingTerm(userMeetingTermVoteRequest: UserMeetingTermVoteRequest, attachments: [String: [Data]], images: [Data], completion: @escaping (Result<APIResponse<String>, NetworkErrorType>) -> Void) {
        meetingRepository.editVoteMeetingTerm(userMeetingTermVoteRequest: userMeetingTermVoteRequest, attachments: attachments, images: images, completion: completion)
    }
}
