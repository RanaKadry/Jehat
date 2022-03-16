//
//  NewAppointmentInteractor.swift
//  Jihat
//
//  Created Ahmed Barghash on 30/09/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

// MARK: NewAppointment Interactor -

class NewAppointmentInteractor: NewAppointmentInteractorInputProtocol {
    
    weak var presenter: NewAppointmentInteractorOutputProtocol?
    private let useCase: AddAppointmentUseCase
    
    init(useCase: AddAppointmentUseCase) {
        self.useCase = useCase
    }
    
    var userToken: String? {
        return useCase.userToken
    }
    
    func getAppointnemtTypes() {
        useCase.getAppointnemtTypes { [weak self] result in
            switch result {
            case .success(let appointmentsResponse):
                if appointmentsResponse.status == true {
                    guard let appointmentTypes = appointmentsResponse.data, !appointmentTypes.isEmpty else { return }
                    DispatchQueue.main.async {
                        self?.presenter?.fetchingAppointmentTypes(appointmentTypes: appointmentTypes)
                    }
                } else {
                    DispatchQueue.main.async {
                        self?.presenter?.fetchingWithError(error: appointmentsResponse.message ?? "")
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.presenter?.fetchingWithError(error: error.rawValue.localized())
                }
            }
        }
    }
    
    func addAppointment(addAppointmentRequest: AddAppointmentRequest, attachments: [String: [Data]]) {
        useCase.addAppointment(addAppointmentRequest: addAppointmentRequest, attachments: attachments) { [weak self] result in
            switch result {
            case .success(let addAppointmentResponse):
                if addAppointmentResponse.status == true {
                    DispatchQueue.main.async {
                        self?.presenter?.fetchingAddAppointmentWithSuccess(message: addAppointmentResponse.message ?? "")
                    }
                } else {
                    DispatchQueue.main.async {
                        self?.presenter?.fetchingWithError(error: addAppointmentResponse.message ?? "")
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.presenter?.fetchingWithError(error: error.rawValue.localized())
                }
            }
        }
    }
}
