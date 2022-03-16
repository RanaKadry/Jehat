//
//  EditDocumentProtocols.swift
//  Jihat
//
//  Created Ahmed Barghash on 13/10/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

// MARK: EditDocument Protocols

protocol EditDocumentViewProtocol: BaseViewProtocol {
    var presenter: EditDocumentPresenterProtocol! { get set }
    
    func set(documentArabicName: String)
    func set(documentEnglishName: String)
    func set(documentNumber: String)
    func set(documentEndDate: String)
    func set(attachemtsCount: String)
    func showAddImagesButton()
    func showAttachmentsImagesButton()
    func refreshCollectionView()
    
    func enableEditDocumentArabicNameTextField()
    func enableEditDocumentEnglishNameTextField()
    func enableEditDocumentNumberTextField()
    func enableEditEndDateTextField()
    func setEndDate(endDate: String)
    func enableAttachmentsCollectionView()
    
    func enableSaveChangesButton()
    func disableSaveChangesButton()
    func startLoadingOnSaveButton()
    func stopLoadingOnSaveButton()
}

protocol EditDocumentPresenterProtocol: BasePresenterProtocol {
    var view: EditDocumentViewProtocol? { get set }
    
    func viewDidLoad()
    
    var attatchmentsCount: Int { get }
    func configureAttatchemtCell(_ cell: AttatchmentCollectionViewCellProtocol, atIndex index: Int)
    func didSelectAttachemt(atIndex index: Int)
    
    func validateInputs(arabicName: String?, englishName: String?, documentNumber: String?, endDate: String?)

    func performEditDocumentArabicName()
    func performEditDocumentEnglishName()
    func performEditDocumentNumber()
    func performEditEndDate()
    func performChangeEndtDate(_ date: Date)
    func performEditAttachments()
    func performDeleteAttachment(atIndex index: Int)
    func performAttachImagesButtonPressed()
    func performAttachDocumentsButtonPressed()
    func performSaveChanges(arabicName: String?, englishName: String?, number: String?, endDate: String?)
    func performDiscardChanges()
    
}

protocol EditDocumentRouterProtocol: BaseRouterProtocol {
    
}

protocol EditDocumentInteractorInputProtocol: BaseInteractorInputProtocol {
    var presenter: EditDocumentInteractorOutputProtocol? { get set }
    
    var userToken: String? { get }
    func getDocumentDetails(documentDetailsRequest: DocumentDetailsRequest)
    func downloadDocument(fileurl: URL)
    func editDocument(addDocumentRequest: EditDocumentRequest, attachments: [String: [Data]], images: [Data])
}

protocol EditDocumentInteractorOutputProtocol: BaseInteractorOutputProtocol {
    func fetchingDocumentDetailsWithSuccess(document: DocumentsResponse)
    func fetchingDownloadedDocumentWithSuccess(localFileUrl: URL)
    func fetchingEditDocumentWithSuccess(message: String)
    func fetchingWithError(error: String)
}
