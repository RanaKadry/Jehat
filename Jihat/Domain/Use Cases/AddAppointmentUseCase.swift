//
//  AddAppointmentUseCase.swift
//  Jihat
//
//  Created by Peter Bassem on 23/11/2021.
//  Copyright © 2021 Jehat. All rights reserved.
//

import Foundation

class AddAppointmentUseCase {
    private let userRepository: UserRepository
    private let appointmentRepository: AppointmentRepoistory
    
    init(userRepository: UserRepository, appointmentRepository: AppointmentRepoistory) {
        self.userRepository = userRepository
        self.appointmentRepository = appointmentRepository
    }
    
    // ------------
    // MARK: - USER
    // ------------
    var userToken: String? {
        return userRepository.userToken
    }
    
    // -------------------
    // MARK: - APPOINTMENT
    // -------------------
    func getAppointnemtTypes(completion: @escaping (Result<APIResponse<[AppointmentTypesResponse]>, NetworkErrorType>) -> Void) {
        appointmentRepository.getAppointnemtTypes(completion: completion)
    }
    
    func addAppointment(addAppointmentRequest: AddAppointmentRequest, attachments: [String: [Data]], completion: @escaping (Result<APIResponse<AuthModel>, NetworkErrorType>) -> Void) {
        appointmentRepository.addAppointment(addAppointmentRequest: addAppointmentRequest, attachments: attachments, completion: completion)
    }
}
