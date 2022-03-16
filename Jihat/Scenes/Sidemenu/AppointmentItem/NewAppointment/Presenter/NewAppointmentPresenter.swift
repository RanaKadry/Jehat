//
//  NewAppointmentPresenter.swift
//  Jihat
//
//  Created Ahmed Barghash on 30/09/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

// MARK: NewAppointment Presenter -

class NewAppointmentPresenter: BasePresenter {

    weak var view: NewAppointmentViewProtocol?
    private let interactor: NewAppointmentInteractorInputProtocol
    private let router: NewAppointmentRouterProtocol
    private let addAppointmentCompletion: ActionCompletion
    
    private var attachmentsData: [String: [Data]] = [:]
    private var alertTypes = [AppointmentTypesResponse]()
    private var alertTypeId: String?
    
    init(view: NewAppointmentViewProtocol, interactor: NewAppointmentInteractorInputProtocol, router: NewAppointmentRouterProtocol, addAppointmentCompletion: @escaping ActionCompletion) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.addAppointmentCompletion = addAppointmentCompletion
    }
}

// MARK: - NewAppointmentPresenterProtocol
extension NewAppointmentPresenter: NewAppointmentPresenterProtocol {
    
    func viewDidLoad() {
        view?.showLoading()
        interactor.getAppointnemtTypes()
    }
    
    func performObserveInputs(address: String?, appointmentDetails: String?, attachedDoucments: String?, startDate: String?, startTime: String?, alertType: String?) {
        let observeInputs = address?.isEmpty == false && appointmentDetails?.isEmpty == false && startDate?.isEmpty == false && startTime?.isEmpty == false && alertType?.isEmpty == false // attachedDoucments?.isEmpty == false && 
        observeInputs ? view?.enableSaveAppointmentButton() : view?.disableSaveAppointmentButton()
    }
    
}

// MARK: - API
extension NewAppointmentPresenter: NewAppointmentInteractorOutputProtocol{
    
    func fetchingAppointmentTypes(appointmentTypes: [AppointmentTypesResponse]) {
        view?.hideLoading()
        self.alertTypes = appointmentTypes
        view?.refreshAlertTypePickerView()
    }
    
    func fetchingAddAppointmentWithSuccess(message: String) {
        view?.stopLoadingOnSaveAppointmentButton()
        view?.showBottomMessage(message)
        addAppointmentCompletion()
        router.popupViewController()
    }
    
    func fetchingWithError(error: String) {
        view?.hideLoading()
        view?.stopLoadingOnSaveAppointmentButton()
        view?.showBottomMessage(error)
    }
}

// MARK: - Selectors
extension NewAppointmentPresenter {
    
    func performBack() {
        router.popupViewController()
    }
    
    func performChangeStartDate(_ date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormates.daySlashMonthSlashYear.rawValue
        view?.setStartDate(startDate: dateFormatter.string(from: date))
    }
    
    func performChangeStartTime(_ time: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormates.time.rawValue
        view?.setStartTime(startTime: dateFormatter.string(from: time))
    }
    
    func performAttachDocuments() {
        attachmentsData.removeAll()
        router.presentDocumentsPickerMultiScreenViewController { [weak self] documentsUrls in
            documentsUrls.forEach {
                do {
                    let fileExtension = String($0.lastPathComponent.split(separator: ".").last!)
                    let urlData = try Data(contentsOf: $0)
                                        
                    if fileExtension.lowercased().contains("pdf") {
                        if self?.attachmentsData["pdf"] != nil {
                            self?.attachmentsData["pdf"]?.append(urlData)
                        } else {
                            self?.attachmentsData["pdf"] = [urlData]
                        }
                    } else if fileExtension.lowercased().contains("txt") {
                        if self?.attachmentsData["txt"] != nil {
                            self?.attachmentsData["txt"]?.append(urlData)
                        } else {
                            self?.attachmentsData["txt"] = [urlData]
                        }
                    } else if fileExtension.lowercased().contains("doc") {
                        if self?.attachmentsData["doc"] != nil {
                            self?.attachmentsData["doc"]?.append(urlData)
                        } else {
                            self?.attachmentsData["doc"] = [urlData]
                        }
                    } else if fileExtension.lowercased().contains("xls") {
                        if self?.attachmentsData["xls"] != nil {
                            self?.attachmentsData["xls"]?.append(urlData)
                        } else {
                            self?.attachmentsData["xls"] = [urlData]
                        }
                    } else if fileExtension.lowercased().contains("ppt") {
                        if self?.attachmentsData["ppt"] != nil {
                            self?.attachmentsData["ppt"]?.append(urlData)
                        } else {
                            self?.attachmentsData["ppt"] = [urlData]
                        }
                    }
                } catch let error {
                    print("Failed to convert attachment to url:", error)
                }
            }
            self?.view?.setAttachedDocumentsCount(documentsCount: String(format: "%@ %@", (documentsUrls.count.localized() ?? ""), "attachments_selected".localized()))
        }
    }
    
    func performSaveAppointment(subject: String?, details: String?, startDate: String?, startTme: String?) {
        guard let userToken = interactor.userToken, userToken != "" else {
            router.presentActionControl(title: "login_alert".localized(), message: nil, firstActionTitle: "login".localized(), firstAction: { [weak self] in
                self?.router.navigateToLoginViewController()
            }, secondActionTitle: "cancel".localized()) { [weak self] in
                self?.router.dismissActionControl()
            }
            return
        }
        let newAppointmentRequest = AddAppointmentRequest(userToken: interactor.userToken, subject: subject, description: details, data: startDate, time: startTme, alertType: alertTypeId)
        view?.startLoadingOnSaveAppointmentButton()
        interactor.addAppointment(addAppointmentRequest: newAppointmentRequest, attachments: attachmentsData)
    }
    
}

// MARK: - AlertTypePickerView Setup
extension NewAppointmentPresenter {
    
    var alertTypeCount: Int {
        return alertTypes.count
    }
    
    func setAlertType(atIndex index: Int) -> String {
        return alertTypes[index].name ?? ""
    }
    
    func didSelectAlertType(atIndex index: Int) {
        alertTypeId = alertTypes[index].id
        view?.displaySelectedAlertType(alertTypes[index].name ?? "")
    }
}
