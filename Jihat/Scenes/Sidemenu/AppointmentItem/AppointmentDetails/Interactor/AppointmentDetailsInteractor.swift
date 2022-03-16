//
//  AppointmentDetailsInteractor.swift
//  Jihat
//
//  Created Ahmed Barghash on 28/10/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

// MARK: AppointmentDetails Interactor -

class AppointmentDetailsInteractor: AppointmentDetailsInteractorInputProtocol {
    
    weak var presenter: AppointmentDetailsInteractorOutputProtocol?
    private let useCase: AppointmentDetailsUseCase
    
    init(useCase: AppointmentDetailsUseCase) {
        self.useCase = useCase
    }
    
    var userToken: String? {
        return useCase.userToken
    }
    
    func getAppointmentDetails(appointmentDetailsRequest: AppointmentDetailsRequest) {
        useCase.getAppointmentDetails(appointmentDetailsRequest: appointmentDetailsRequest) { [weak self] result in
            switch result {
            case .success(let appointmentDetailsResponse):
                if appointmentDetailsResponse.status == true {
                    guard let appointment = appointmentDetailsResponse.data else { return }
                    DispatchQueue.main.async {
                        self?.presenter?.fetchingAppointmentDetailsWithSucess(appointment: appointment)
                    }
                } else {
                    DispatchQueue.main.async {
                        self?.presenter?.fethcingWithError(error: appointmentDetailsResponse.message ?? "")
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.presenter?.fethcingWithError(error: error.rawValue.localized())
                }
            }
        }
    }
    
    func downloadDocument(fileurl: URL) {
        useCase.downloadDocument(fileurl: fileurl) { [weak self] url in
            guard let url = url else { return }
            self?.presenter?.fetchingDownloadedDocumentWithSuccess(localFileUrl: url)
        }
    }
}
