//
//  AddAttachmentsPresenter.swift
//  Jihat
//
//  Created by Peter Bassem on 03/12/2021.
//  Copyright © 2021 Jehat. All rights reserved.
//
//

import Foundation

// MARK: AddAttachments Presenter -

class AddAttachmentsPresenter: BasePresenter {

    weak var view: AddAttachmentsViewProtocol?
    private let interactor: AddAttachmentsInteractorInputProtocol
    private let router: AddAttachmentsRouterProtocol
    private let orderId: String?
    private let addAttachmentsCompletion: ActionCompletion
    
    private var attachmentsData: [String: [Data]] = [:]
    private var imagesData: [Data] = []
    
    init(view: AddAttachmentsViewProtocol, interactor: AddAttachmentsInteractorInputProtocol, router: AddAttachmentsRouterProtocol, orderId: String?, addAttachmentsCompletion: @escaping ActionCompletion) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.orderId = orderId
        self.addAttachmentsCompletion = addAttachmentsCompletion
    }
}

// MARK: - AddAttachmentsPresenterProtocol
extension AddAttachmentsPresenter: AddAttachmentsPresenterProtocol {
    
    func viewDidLoad() {
        
    }
    
    func performValidateInputs(documents: String?, images: String?) {
        let validateInputs = documents?.isEmpty == false || images?.isEmpty == false
        validateInputs ? view?.showSaveButton() : view?.hideSaveButton()
    }
}

// MARK: - API
extension AddAttachmentsPresenter: AddAttachmentsInteractorOutputProtocol {
    
    func fetchingAddAttachmentsWithSuccess() {
        addAttachmentsCompletion()
        view?.stopLoadingOnSaveButton()
        router.dismissViewController()
    }
    
    func fetchingWithError(error: String) {
        view?.stopLoadingOnSaveButton()
        view?.showBottomMessage(error)
    }
}

// MARK: - Selectors
extension AddAttachmentsPresenter {
    
    func performBack() {
        router.dismissViewController()
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
    
    func performSaveButtonPressed(note: String?) {
        view?.startLoadingOnSaveButton()
        let sendComment = note == "add_comment".localized() ? "-" : note
        let addOrderCommentRequest = AddOrderCommentRequest(userToken: interactor.userToken, orderId: orderId, comment: sendComment ?? "")
        interactor.addOrderComment(addOrderCommentRequest: addOrderCommentRequest, attachments: attachmentsData, body: [:], images: imagesData)
    }
}
