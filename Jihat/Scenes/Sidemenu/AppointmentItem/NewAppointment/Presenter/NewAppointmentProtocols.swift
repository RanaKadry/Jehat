//
//  NewAppointmentProtocols.swift
//  Jihat
//
//  Created Ahmed Barghash on 30/09/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

// MARK: NewAppointment Protocols

protocol NewAppointmentViewProtocol: BaseViewProtocol {
    var presenter: NewAppointmentPresenterProtocol! { get set }
    
    func setAttachedDocumentsCount(documentsCount: String)
    func setStartDate(startDate: String)
    func setStartTime(startTime: String)
    func refreshAlertTypePickerView()
    func displaySelectedAlertType(_ alertType: String)
    func enableSaveAppointmentButton()
    func disableSaveAppointmentButton()
    func startLoadingOnSaveAppointmentButton()
    func stopLoadingOnSaveAppointmentButton()
}

protocol NewAppointmentPresenterProtocol: BasePresenterProtocol {
    var view: NewAppointmentViewProtocol? { get set }
    
    func viewDidLoad()

    func performObserveInputs(address: String?, appointmentDetails: String?, attachedDoucments: String?, startDate: String?, startTime: String?, alertType: String?)
    func performChangeStartDate(_ date: Date)
    func performChangeStartTime(_ time: Date)
    
    var alertTypeCount: Int { get }
    func setAlertType(atIndex index: Int) -> String
    func didSelectAlertType(atIndex index: Int)
    
    func performBack()
    func performAttachDocuments()
    func performSaveAppointment(subject: String?, details: String?, startDate: String?, startTme: String?)
}

protocol NewAppointmentRouterProtocol: BaseRouterProtocol {
    func navigateToLoginViewController()
}

protocol NewAppointmentInteractorInputProtocol: BaseInteractorInputProtocol {
    var presenter: NewAppointmentInteractorOutputProtocol? { get set }
    
    var userToken: String? { get }
    func getAppointnemtTypes()
    func addAppointment(addAppointmentRequest: AddAppointmentRequest, attachments: [String: [Data]])
}

protocol NewAppointmentInteractorOutputProtocol: BaseInteractorOutputProtocol {
    func fetchingAppointmentTypes(appointmentTypes: [AppointmentTypesResponse])
    func fetchingAddAppointmentWithSuccess(message: String)
    func fetchingWithError(error: String)
}
