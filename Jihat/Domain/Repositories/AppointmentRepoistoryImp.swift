//
//  AppointmentRepoistoryImp.swift
//  Jihat
//
//  Created by Peter Bassem on 13/11/2021.
//  Copyright © 2021 Jehat. All rights reserved.
//

import Foundation

class AppointmentRepoistoryImp: AppointmentRepoistory {
    
    private let remoteAppointmentDataSource = RemoteAppointmentDataSource()
    
    func getUserAppointments(appointmentsRequest: UserAppointmentsRequest, completion: @escaping (Result<APIResponse<[UserAppointmentsResponse]>, NetworkErrorType>) -> Void) {
        remoteAppointmentDataSource.getAppointments(from: .getAppointments(appointmentsRequest: appointmentsRequest), completion: completion)
    }
    
    func getAppointmentDetails(appointmentDetailsRequest: AppointmentDetailsRequest, completion: @escaping (Result<APIResponse<UserAppointmentsResponse>, NetworkErrorType>) -> Void) {
        remoteAppointmentDataSource.getAppointmentDetails(from: .getAppointmentDetails(appointmentDetailsRequest: appointmentDetailsRequest), completion: completion)
    }
    
    func getAppointnemtTypes(completion: @escaping (Result<APIResponse<[AppointmentTypesResponse]>, NetworkErrorType>) -> Void) {
        remoteAppointmentDataSource.getAppointnemtTypes(from: .getAppointmentTypes, completion: completion)
    }
    
    func addAppointment(addAppointmentRequest: AddAppointmentRequest, attachments: [String: [Data]], completion: @escaping (Result<APIResponse<AuthModel>, NetworkErrorType>) -> Void) {
        remoteAppointmentDataSource.addNewAppointment(from: KNetworkConstants.EndPoint.addAppointment.rawValue, addAppointmentRequest: addAppointmentRequest, attachments: attachments, completion: completion)
    }
}
