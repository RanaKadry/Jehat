//
//  RemoteAppointmentDataSource.swift
//  Jihat
//
//  Created by Peter Bassem on 13/11/2021.
//  Copyright © 2021 Jehat. All rights reserved.
//

import Foundation

class RemoteAppointmentDataSource {
    
    func getAppointments(from apiRouter: APIRouter, completion: @escaping (Result<APIResponse<[UserAppointmentsResponse]>, NetworkErrorType>) -> Void) {
        APIClient.performRequest(route: apiRouter).execute { response in
            completion(.success(response))
        } onFailure: { error in
            completion(.failure(error))
        }
    }
    
    func getAppointmentDetails(from apiRouter: APIRouter, completion: @escaping (Result<APIResponse<UserAppointmentsResponse>, NetworkErrorType>) -> Void) {
        APIClient.performRequest(route: apiRouter).execute { response in
            completion(.success(response))
        } onFailure: { error in
            completion(.failure(error))
        }
    }
    
    func getAppointnemtTypes(from apiRouter: APIRouter, completion: @escaping (Result<APIResponse<[AppointmentTypesResponse]>, NetworkErrorType>) -> Void) {
        APIClient.performRequest(route: apiRouter).execute { response in
            completion(.success(response))
        } onFailure: { error in
            completion(.failure(error))
        }
    }
    
    func addNewAppointment(from endPoint: String, addAppointmentRequest: AddAppointmentRequest, attachments: [String: [Data]], completion: @escaping (Result<APIResponse<AuthModel>, NetworkErrorType>) -> Void) {
        APIClient.uploadAttachments(endUrl: endPoint, paramsType: AddAppointmentRequest.self, params: addAppointmentRequest, attachments: attachments, images: nil, type: APIResponse<AuthModel>.self, completion: completion)
    }
}
