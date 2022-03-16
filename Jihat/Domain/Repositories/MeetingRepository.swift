//
//  MeetingRepository.swift
//  Jihat
//
//  Created by Peter Bassem on 20/11/2021.
//  Copyright © 2021 Jehat. All rights reserved.
//

import Foundation

protocol MeetingRepository {
    func getUserMeetings(meetingsRequest: UserMeetingsRequest, completion: @escaping (Result<APIResponse<[UserMeetingsResponse]>, NetworkErrorType>) -> Void)
    func getMeetingFilterItems(completion: @escaping (Result<APIResponse<[MeetingFilterItemsResponse]>, NetworkErrorType>) -> Void)
    func getMeetingDetails(userMeetingDetailsRequest: UserMeetingDetailsRequest, completion: @escaping (Result<APIResponse<UserMeetingDetailsResponse>, NetworkErrorType>) -> Void)
    func attendMeeting(attendMeetingRequest: UserMeetingDetailsRequest, completion: @escaping (Result<APIResponse<EmptyResponse>, NetworkErrorType>) -> Void)
    func getMeetingTerms(userMeetingDetailsRequest: UserMeetingDetailsRequest, completion: @escaping (Result<APIResponse<[UserMeetingTermsResponse]>, NetworkErrorType>) -> Void)
    func voteMeetingTerm(userMeetingTermVoteRequest: UserMeetingTermVoteRequest, attachments: [String: [Data]], images: [Data], completion: @escaping (Result<APIResponse<String>, NetworkErrorType>) -> Void)
    func editVoteMeetingTerm(userMeetingTermVoteRequest: UserMeetingTermVoteRequest, attachments: [String: [Data]], images: [Data], completion: @escaping (Result<APIResponse<String>, NetworkErrorType>) -> Void)
    func getMeetingCandidates(userMeetingCandidatesRequest: UserMeetingDetailsRequest, completion: @escaping (Result<APIResponse<UserMeetingCandidatesResponse>, NetworkErrorType>) -> Void)
    func voteMeetingCandidates(voteMeetingCandidate: UserMeetingDetailsRequest, bodyData: Data, completion: @escaping (Result<APIResponse<String>, NetworkErrorType>) -> Void)
    func voteMeetingCandidatesTypeTwo(voteMeetingCandidate: UserMeetingDetailsRequest, bodyData: Data, completion: @escaping (Result<APIResponse<String>, NetworkErrorType>) -> Void)
    func voteMeetingCandidatesTypeThree(voteMeetingCandidate: UserMeetingDetailsRequest, bodyData: Data, completion: @escaping (Result<APIResponse<String>, NetworkErrorType>) -> Void)
}
