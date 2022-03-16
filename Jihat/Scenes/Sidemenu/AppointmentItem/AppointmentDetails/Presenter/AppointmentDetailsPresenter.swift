//
//  AppointmentDetailsPresenter.swift
//  Jihat
//
//  Created Ahmed Barghash on 28/10/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

// MARK: AppointmentDetails Presenter -

class AppointmentDetailsPresenter: BasePresenter {

    weak var view: AppointmentDetailsViewProtocol?
    private let interactor: AppointmentDetailsInteractorInputProtocol
    private let router: AppointmentDetailsRouterProtocol
    private let appointmentId: String?
    
    private var attachments: [String] = []
    
    init(view: AppointmentDetailsViewProtocol, interactor: AppointmentDetailsInteractorInputProtocol, router: AppointmentDetailsRouterProtocol, appointmentId: String?) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.appointmentId = appointmentId
    }
    
}

// MARK: - AppointmentDetailsPresenterProtocol
extension AppointmentDetailsPresenter: AppointmentDetailsPresenterProtocol {

    func viewDidLoad() {
        view?.showLoading()
        let appointmentDetailsRequest = AppointmentDetailsRequest(userToken: interactor.userToken, appointmentId: appointmentId)
        interactor.getAppointmentDetails(appointmentDetailsRequest: appointmentDetailsRequest)
    }
}

// MARK: - API
extension AppointmentDetailsPresenter: AppointmentDetailsInteractorOutputProtocol {
    
    func fetchingAppointmentDetailsWithSucess(appointment: UserAppointmentsResponse) {
        view?.hideLoading()
        view?.set(appointmentTitle: appointment.subject ?? "")
        view?.set(appointmentDetails: appointment.discription ?? "")
        let attachmentsCount = LocalizationHelper.isArabic() ? appointment.attachments?.count.toString().enToArDigits : appointment.attachments?.count.toString().arToEnDigits
        view?.set(attachemtsCount: String(format: "%@ %@ %@", "number".localized(), (attachmentsCount ?? ""), "attached_files".localized()))
        self.attachments = appointment.attachments ?? []
        view?.refreshCollectionView()
        let dateString = String(appointment.date?.split(separator: "-").last ?? "")
        view?.set(appointmentDate: dateString)
        view?.set(appointmentTime: appointment.time ?? "")
        view?.set(alertType: appointment.type ?? "")
    }
    
    func fetchingDownloadedDocumentWithSuccess(localFileUrl: URL) {
        router.presentDocumentPreveiwViewController(fileurl: localFileUrl)
    }
    
    func fethcingWithError(error: String) {
        view?.hideLoading()
        view?.showBottomMessage(error)
    }
}

// MARK: - Selectors
extension AppointmentDetailsPresenter {
    
    func performBack() {
        router.popupViewController()
    }
}

// MARK: - AttatchmentsCollectionView Setup
extension AppointmentDetailsPresenter {
    
    var attatchmentsCount: Int {
        return attachments.count
    }
    
    func configureAttatchemtCell(_ cell: AttatchmentCollectionViewCellProtocol, atIndex index: Int) {
        let attachment = attachments[index]
        if (attachment).contains("jpeg") || (attachment).contains("jpg") {
            cell.setImage(attachment)
        } else {
            if (attachment).contains("pdf") {
                cell.setImage(image: DesignSystem.Icon.pdf.image)
            } else if (attachment).contains("doc") {
                cell.setImage(image: DesignSystem.Icon.word.image)
            } else if (attachment).contains("xls") {
                cell.setImage(image: DesignSystem.Icon.excel.image)
            } else if (attachment).contains("ppt") {
                cell.setImage(image: DesignSystem.Icon.powerpoint.image)
            } else if (attachment).contains("txt") {
                cell.setImage(image: DesignSystem.Icon.txt.image)
            }
        }
    }
    
    func didSelectAttachemt(atIndex index: Int) {
        let attachment = attachments[index]
        guard let url = URL(string: attachment) else { return }
        interactor.downloadDocument(fileurl: url)
    }
}
