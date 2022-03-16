//
//  AddNewDocumentsProtocols.swift
//  Jihat
//
//  Created Ahmed Barghash on 12/10/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

// MARK: AddNewDocuments Protocols

protocol AddNewDocumentsViewProtocol: BaseViewProtocol {
    var presenter: AddNewDocumentsPresenterProtocol! { get set }
    
    func enableSaveButton()
    func disableSaveButton()
    func setEndDate(endDate: String)
    func setPickedAttachmentsNumber(attachmentsNumber: String)
    func setPickedImagesNumber(imagesNumber: String)
    
    func startLoadingOnSaveButton()
    func stopLoadingOnSaveButton()
}

protocol AddNewDocumentsPresenterProtocol: BasePresenterProtocol {
    var view: AddNewDocumentsViewProtocol? { get set }
    
    func viewDidLoad()

    func performObserveInputs(documentArabicName: String?, documentEnglishName: String?, documentNumber: String?, endDate: String?, attachedDocuments: String?, pickedImage: String?)
    func performChangeEndtDate(_ date: Date)
    
    func performBack()
    func performAttachDocumentsButtonPressed()
    func performAttachImagesButtonPressed()
    func performSaveDocument(arabicName: String?, englishName: String?, number: String?, endDate: String?)
}

protocol AddNewDocumentsRouterProtocol: BaseRouterProtocol {
    func navigateToLoginViewController()
}

protocol AddNewDocumentsInteractorInputProtocol: BaseInteractorInputProtocol {
    var presenter: AddNewDocumentsInteractorOutputProtocol? { get set }
    
    var userToken: String? { get }
    func addNewDocument(addDocumentRequest: AddDocumentRequest, attachments: [String: [Data]], images: [Data])
}

protocol AddNewDocumentsInteractorOutputProtocol: BaseInteractorOutputProtocol {
    func fetchingAddDocumentWithSuccess(message: String)
    func fetchingAddDocumentWithFail(error: String)
}
