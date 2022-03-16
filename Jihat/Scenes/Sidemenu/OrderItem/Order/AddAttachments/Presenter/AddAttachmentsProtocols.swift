//
//  AddAttachmentsProtocols.swift
//  Jihat
//
//  Created by Peter Bassem on 03/12/2021.
//  Copyright © 2021 Jehat. All rights reserved.
//
//

import Foundation

// MARK: AddAttachments Protocols

protocol AddAttachmentsViewProtocol: BaseViewProtocol {
    var presenter: AddAttachmentsPresenterProtocol! { get set }
    
    func setPickedAttachmentsNumber(attachmentsNumber: String)
    func setPickedImagesNumber(imagesNumber: String)
    func showSaveButton()
    func hideSaveButton()
    func startLoadingOnSaveButton()
    func stopLoadingOnSaveButton()
}

protocol AddAttachmentsPresenterProtocol: BasePresenterProtocol {
    var view: AddAttachmentsViewProtocol? { get set }
    
    func viewDidLoad()
    
    func performValidateInputs(documents: String?, images: String?)
    
    func performBack()
    func performAttachDocumentsButtonPressed()
    func performAttachImagesButtonPressed()
    func performSaveButtonPressed(note: String?)

}

protocol AddAttachmentsRouterProtocol: BaseRouterProtocol {
    
}

protocol AddAttachmentsInteractorInputProtocol: BaseInteractorInputProtocol {
    var presenter: AddAttachmentsInteractorOutputProtocol? { get set }
    
    var userToken: String? { get }
    func addOrderComment(addOrderCommentRequest: AddOrderCommentRequest, attachments: [String: [Data]], body: [String: Any], images: [Data])
}

protocol AddAttachmentsInteractorOutputProtocol: BaseInteractorOutputProtocol {
    func fetchingAddAttachmentsWithSuccess()
    func fetchingWithError(error: String)
}
