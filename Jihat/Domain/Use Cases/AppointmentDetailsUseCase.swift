//
//  AppointmentDetailsUseCase.swift
//  Jihat
//
//  Created by Peter Bassem on 14/11/2021.
//  Copyright © 2021 Jehat. All rights reserved.
//

import Foundation

class AppointmentDetailsUseCase {
    private let userRepository: UserRepository
    private let appointmentRepository: AppointmentRepoistory
    private let documentRepository: DocumentRepository
    
    init(userRepository: UserRepository, appointmentRepository: AppointmentRepoistory, documentRepository: DocumentRepository) {
        self.userRepository = userRepository
        self.appointmentRepository = appointmentRepository
        self.documentRepository = documentRepository
    }
    
    // ------------
    // MARK: - USER
    // ------------
    var userToken: String? {
        return userRepository.userToken
    }
    
    // MARK: - APPOINTMENT
    func getAppointmentDetails(appointmentDetailsRequest: AppointmentDetailsRequest, completion: @escaping (Result<APIResponse<UserAppointmentsResponse>, NetworkErrorType>) -> Void) {
        appointmentRepository.getAppointmentDetails(appointmentDetailsRequest: appointmentDetailsRequest, completion: completion)
    }
    
    // ----------------
    // MARK: - DOCUEMNT
    // ----------------
    func downloadDocument(fileurl: URL, completion: @escaping (URL?) -> Void) {
        documentRepository.downloadDocument(fileurl: fileurl, completion: completion)
    }
}
