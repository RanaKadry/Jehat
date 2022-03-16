//
//  AppointmentDetailsProtocols.swift
//  Jihat
//
//  Created Ahmed Barghash on 28/10/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

// MARK: AppointmentDetails Protocols

protocol AppointmentDetailsViewProtocol: BaseViewProtocol {
    var presenter: AppointmentDetailsPresenterProtocol! { get set }
    
    func set(appointmentTitle: String)
    func set(appointmentDetails: String)
    func set(attachemtsCount: String)
    func refreshCollectionView()
    func set(appointmentDate: String)
    func set(appointmentTime: String)
    func set(alertType: String)
}

protocol AppointmentDetailsPresenterProtocol: BasePresenterProtocol {
    var view: AppointmentDetailsViewProtocol? { get set }
    
    func viewDidLoad()
    
    var attatchmentsCount: Int { get }
    func configureAttatchemtCell(_ cell: AttatchmentCollectionViewCellProtocol, atIndex index: Int)
    func didSelectAttachemt(atIndex index: Int)

    func performBack()
}

protocol AppointmentDetailsRouterProtocol: BaseRouterProtocol {
    
}

protocol AppointmentDetailsInteractorInputProtocol: BaseInteractorInputProtocol {
    var presenter: AppointmentDetailsInteractorOutputProtocol? { get set }
    
    var userToken: String? { get }
    func getAppointmentDetails(appointmentDetailsRequest: AppointmentDetailsRequest)
    func downloadDocument(fileurl: URL)
}

protocol AppointmentDetailsInteractorOutputProtocol: BaseInteractorOutputProtocol {
    func fetchingAppointmentDetailsWithSucess(appointment: UserAppointmentsResponse)
    func fetchingDownloadedDocumentWithSuccess(localFileUrl: URL)
    func fethcingWithError(error: String)
}
