//
//  AddNewDocumentsPresenter.swift
//  Jihat
//
//  Created Ahmed Barghash on 12/10/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

// MARK: AddNewDocuments Presenter -

class AddNewDocumentsPresenter: BasePresenter {

    weak var view: AddNewDocumentsViewProtocol?
    private let interactor: AddNewDocumentsInteractorInputProtocol
    private let router: AddNewDocumentsRouterProtocol
    private let successAddDocumentCompletion: ActionCompletion
    
    private var attachmentsData: [String: [Data]] = [:]
    private var imagesData: [Data] = []
    
    init(view: AddNewDocumentsViewProtocol, interactor: AddNewDocumentsInteractorInputProtocol, router: AddNewDocumentsRouterProtocol, successAddDocumentCompletion: @escaping ActionCompletion) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.successAddDocumentCompletion = successAddDocumentCompletion
    }
    
}

// MARK: - AddNewDocumentsPresenter
extension AddNewDocumentsPresenter: AddNewDocumentsPresenterProtocol {
    
    func viewDidLoad() {
        
    }
    
    
    func performObserveInputs(documentArabicName: String?, documentEnglishName: String?, documentNumber: String?, endDate: String?, attachedDocuments: String?, pickedImage: String?) {
        let observeInputs = documentArabicName?.isEmpty == false && documentEnglishName?.isEmpty == false && documentNumber?.isEmpty == false && endDate?.isEmpty == false && attachedDocuments?.isEmpty == false && pickedImage?.isEmpty == false
        observeInputs ? view?.enableSaveButton() : view?.disableSaveButton()
    }
}

// MARK: - API
extension AddNewDocumentsPresenter: AddNewDocumentsInteractorOutputProtocol {
    
    func fetchingAddDocumentWithSuccess(message: String) {
        view?.stopLoadingOnSaveButton()
        view?.showBottomMessage(message)
        successAddDocumentCompletion()
        router.popupViewController()
    }
    
    func fetchingAddDocumentWithFail(error: String) {
        view?.stopLoadingOnSaveButton()
        view?.showBottomMessage(error)
    }
}

// MARK: - Selectors
extension AddNewDocumentsPresenter {
    
    func performBack() {
        router.popupViewController()
    }
    
    func performChangeEndtDate(_ date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormates.daySlashMonthSlashYear.rawValue
        view?.setEndDate(endDate: dateFormatter.string(from: date))
    }
    
    func performAttachDocumentsButtonPressed() {
        attachmentsData.removeAll()
        router.presentDocumentsPickerMultiScreenViewController { [weak self] urls in
            urls.forEach {
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
            self?.view?.setPickedAttachmentsNumber(attachmentsNumber: String(format: "%@ %@", (urls.count.localized() ?? ""), "attachments_selected".localized()))
        }
    }
    
    func performAttachImagesButtonPressed() {
        router.presentImagePickerMultiSelectViewController(imagesLimit: 5) { [weak self] images, _ in
            self?.imagesData = images.map { $0.jpegData(compressionQuality: 0.8) ?? Data() }
            self?.view?.setPickedImagesNumber(imagesNumber: String(format: "%@ %@", (images.count.localized() ?? ""), "images_selected".localized()))
        }
    }
    
    func performSaveDocument(arabicName: String?, englishName: String?, number: String?, endDate: String?) {
        guard let userToken = interactor.userToken, userToken != "" else {
            router.presentActionControl(title: "login_alert".localized(), message: nil, firstActionTitle: "login".localized(), firstAction: { [weak self] in
                self?.router.navigateToLoginViewController()
            }, secondActionTitle: "cancel".localized()) { [weak self] in
                self?.router.dismissActionControl()
            }
            return
        }
        guard !attachmentsData.isEmpty || !imagesData.isEmpty else { return }
        let addDocumentRequest = AddDocumentRequest(userToken: interactor.userToken, arabicName: arabicName, englishName: englishName, number: number, expirationDate: endDate)
        view?.startLoadingOnSaveButton()
        interactor.addNewDocument(addDocumentRequest: addDocumentRequest, attachments: attachmentsData, images: imagesData)
    }
}
