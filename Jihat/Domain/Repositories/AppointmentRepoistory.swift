//
//  AppointmentRepoistory.swift
//  Jihat
//
//  Created by Peter Bassem on 13/11/2021.
//  Copyright © 2021 Jehat. All rights reserved.
//

import Foundation

protocol AppointmentRepoistory {
    func getUserAppointments(appointmentsRequest: UserAppointmentsRequest, completion: @escaping (Result<APIResponse<[UserAppointmentsResponse]>, NetworkErrorType>) -> Void)
    func getAppointmentDetails(appointmentDetailsRequest: AppointmentDetailsRequest, completion: @escaping (Result<APIResponse<UserAppointmentsResponse>, NetworkErrorType>) -> Void)
    func getAppointnemtTypes(completion: @escaping (Result<APIResponse<[AppointmentTypesResponse]>, NetworkErrorType>) -> Void)
    func addAppointment(addAppointmentRequest: AddAppointmentRequest, attachments: [String: [Data]], completion: @escaping (Result<APIResponse<AuthModel>, NetworkErrorType>) -> Void)
}
