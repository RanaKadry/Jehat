//
//  MeetingRepositoryImp.swift
//  Jihat
//
//  Created by Peter Bassem on 20/11/2021.
//  Copyright © 2021 Jehat. All rights reserved.
//

import Foundation

class MeetingRepositoryImp: MeetingRepository {
    
    private let remoteMeetingDataSource = RemoteMeetingDataSource()
    
    func getUserMeetings(meetingsRequest: UserMeetingsRequest, completion: @escaping (Result<APIResponse<[UserMeetingsResponse]>, NetworkErrorType>) -> Void) {
        remoteMeetingDataSource.getMeetings(from: .getMeetings(meetingsRequest: meetingsRequest), completion: completion)
    }
    
    func getMeetingFilterItems(completion: @escaping (Result<APIResponse<[MeetingFilterItemsResponse]>, NetworkErrorType>) -> Void) {
        remoteMeetingDataSource.getMeetingFilterItems(from: .getMeetingsFilterItems, completion: completion)
    }
    
    func getMeetingDetails(userMeetingDetailsRequest: UserMeetingDetailsRequest, completion: @escaping (Result<APIResponse<UserMeetingDetailsResponse>, NetworkErrorType>) -> Void) {
        remoteMeetingDataSource.getMeetingDetails(from: .getMeetingDetails(userMeetingDetailsRequest: userMeetingDetailsRequest), completion: completion)
    }
    
    func attendMeeting(attendMeetingRequest: UserMeetingDetailsRequest, completion: @escaping (Result<APIResponse<EmptyResponse>, NetworkErrorType>) -> Void) {
        remoteMeetingDataSource.attendMeeting(from: .attendMeeting(attendMeetingRequest: attendMeetingRequest), completion: completion)
    }
    
    func getMeetingTerms(userMeetingDetailsRequest: UserMeetingDetailsRequest, completion: @escaping (Result<APIResponse<[UserMeetingTermsResponse]>, NetworkErrorType>) -> Void) {
        remoteMeetingDataSource.getMeetingTerms(from: .getMeetingTerms(userMeetingTermsRequest: userMeetingDetailsRequest), completion: completion)
    }
    
    func voteMeetingTerm(userMeetingTermVoteRequest: UserMeetingTermVoteRequest, attachments: [String: [Data]], images: [Data], completion: @escaping (Result<APIResponse<String>, NetworkErrorType>) -> Void) {
        remoteMeetingDataSource.voteMeetingTerm(endPoint: KNetworkConstants.EndPoint.voteMeetingTerm.rawValue, userMeetingTermVoteRequest: userMeetingTermVoteRequest, attachments: attachments, images: images, completion: completion)
    }
    
    func editVoteMeetingTerm(userMeetingTermVoteRequest: UserMeetingTermVoteRequest, attachments: [String: [Data]], images: [Data], completion: @escaping (Result<APIResponse<String>, NetworkErrorType>) -> Void) {
        remoteMeetingDataSource.voteMeetingTerm(endPoint: KNetworkConstants.EndPoint.editVoteMeetingTerm.rawValue, userMeetingTermVoteRequest: userMeetingTermVoteRequest, attachments: attachments, images: images, completion: completion)
    }
    
    func getMeetingCandidates(userMeetingCandidatesRequest: UserMeetingDetailsRequest, completion: @escaping (Result<APIResponse<UserMeetingCandidatesResponse>, NetworkErrorType>) -> Void) {
        remoteMeetingDataSource.getMeetingCandidates(from: .getMeetingCandidates(userMeetingCandidatesRequest: userMeetingCandidatesRequest), completion: completion)
    }
    
    func voteMeetingCandidates(voteMeetingCandidate: UserMeetingDetailsRequest, bodyData: Data, completion: @escaping (Result<APIResponse<String>, NetworkErrorType>) -> Void) {
        remoteMeetingDataSource.voteMeetingCandidates(from: KNetworkConstants.EndPoint.voteCandidateTypeOne.rawValue, voteMeetingCandidate: voteMeetingCandidate, bodyData: bodyData, completion: completion)
    }
    
    func voteMeetingCandidatesTypeTwo(voteMeetingCandidate: UserMeetingDetailsRequest, bodyData: Data, completion: @escaping (Result<APIResponse<String>, NetworkErrorType>) -> Void) {
        remoteMeetingDataSource.voteMeetingCandidatesTypeTwo(from: KNetworkConstants.EndPoint.voteCandidateTypeTwo.rawValue, voteMeetingCandidate: voteMeetingCandidate, bodyData: bodyData, completion: completion)
    }
    
    func voteMeetingCandidatesTypeThree(voteMeetingCandidate: UserMeetingDetailsRequest, bodyData: Data, completion: @escaping (Result<APIResponse<String>, NetworkErrorType>) -> Void) {
        remoteMeetingDataSource.voteMeetingCandidatesTypeThree(from: KNetworkConstants.EndPoint.voteCandidateTypeThree.rawValue, voteMeetingCandidate: voteMeetingCandidate, bodyData: bodyData, completion: completion)
    }
}
