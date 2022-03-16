//
//  RemoteMeetingDataSource.swift
//  Jihat
//
//  Created by Peter Bassem on 20/11/2021.
//  Copyright © 2021 Jehat. All rights reserved.
//

import Foundation

class RemoteMeetingDataSource {
    
    func getMeetings(from apiRouter: APIRouter, completion: @escaping (Result<APIResponse<[UserMeetingsResponse]>, NetworkErrorType>) -> Void) {
        APIClient.performRequest(route: apiRouter).execute { response in
            completion(.success(response))
        } onFailure: { error in
            completion(.failure(error))
        }
    }
    
    func getMeetingFilterItems(from apiRouter: APIRouter, completion: @escaping (Result<APIResponse<[MeetingFilterItemsResponse]>, NetworkErrorType>) -> Void) {
        APIClient.performRequest(route: apiRouter).execute { response in
            completion(.success(response))
        } onFailure: { error in
            completion(.failure(error))
        }
    }
    
    func getMeetingDetails(from apiRouter: APIRouter, completion: @escaping (Result<APIResponse<UserMeetingDetailsResponse>, NetworkErrorType>) -> Void) {
        APIClient.performRequest(route: apiRouter).execute { response in
            completion(.success(response))
        } onFailure: { error in
            completion(.failure(error))
        }
    }
    
    func attendMeeting(from apiRouter: APIRouter, completion: @escaping (Result<APIResponse<EmptyResponse>, NetworkErrorType>) -> Void) {
        APIClient.performRequest(route: apiRouter).execute { response in
            completion(.success(response))
        } onFailure: { error in
            completion(.failure(error))
        }
    }
    
    func getMeetingTerms(from apiRouter: APIRouter, completion: @escaping (Result<APIResponse<[UserMeetingTermsResponse]>, NetworkErrorType>) -> Void) {
        APIClient.performRequest(route: apiRouter).execute { response in
            completion(.success(response))
        } onFailure: { error in
            completion(.failure(error))
        }
    }
    
    func voteMeetingTerm(endPoint: String, userMeetingTermVoteRequest: UserMeetingTermVoteRequest, attachments: [String: [Data]], images: [Data], completion: @escaping (Result<APIResponse<String>, NetworkErrorType>) -> Void) {
        APIClient.uploadAttachments(endUrl: endPoint, paramsType: UserMeetingTermVoteRequest.self, params: userMeetingTermVoteRequest, attachments: attachments, images: images, type: APIResponse<String>.self, completion: completion)
    }
    
    func getMeetingCandidates(from apiRouter: APIRouter, completion: @escaping (Result<APIResponse<UserMeetingCandidatesResponse>, NetworkErrorType>) -> Void) {
        APIClient.performRequest(route: apiRouter).execute { response in
            completion(.success(response))
        } onFailure: { error in
            completion(.failure(error))
        }
    }
    
    func voteMeetingCandidates(from endPoint: String, voteMeetingCandidate: UserMeetingDetailsRequest, bodyData: Data, completion: @escaping (Result<APIResponse<String>, NetworkErrorType>) -> Void) {
        APIClient.performCustomRequest(endUrl: endPoint, paramsType: UserMeetingDetailsRequest.self, params: voteMeetingCandidate, body: bodyData, type: APIResponse<String>.self, completion: completion)
    }
    
    func voteMeetingCandidatesTypeTwo(from endPoint: String, voteMeetingCandidate: UserMeetingDetailsRequest, bodyData: Data, completion: @escaping (Result<APIResponse<String>, NetworkErrorType>) -> Void) {
        APIClient.performCustomRequest(endUrl: endPoint, paramsType: UserMeetingDetailsRequest.self, params: voteMeetingCandidate, body: bodyData, type: APIResponse<String>.self, completion: completion)
    }
    
    func voteMeetingCandidatesTypeThree(from endPoint: String, voteMeetingCandidate: UserMeetingDetailsRequest, bodyData: Data, completion: @escaping (Result<APIResponse<String>, NetworkErrorType>) -> Void) {
        APIClient.performCustomRequest(endUrl: endPoint, paramsType: UserMeetingDetailsRequest.self, params: voteMeetingCandidate, body: bodyData, type: APIResponse<String>.self, completion: completion)
    }
}
