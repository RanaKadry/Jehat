//
//  AddVoiceNoteProtocols.swift
//  Jihat
//
//  Created Peter Bassem on 13/10/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

// MARK: AddVoiceNote Protocols

protocol AddVoiceNoteViewProtocol: BaseViewProtocol {
    var presenter: AddVoiceNotePresenterProtocol! { get set }
    
    func showSaveButton()
    func hideSaveButton()
    func showLoadingOnSaveButton()
    func hideLoadingOnSaveButton()
    func showResetButton()
    func hideResetButton()
}

protocol AddVoiceNotePresenterProtocol: BasePresenterProtocol {
    var view: AddVoiceNoteViewProtocol? { get set }
    
    func viewDidLoad()

    func performBack()
    func performFinishRecording()
    func performResetRecording()
    func performShowResetButton()
    func performHideResetButton()
    func performCancelButton()
    func performSaveButton(comment: String?, audioURL: URL?)
}

protocol AddVoiceNoteRouterProtocol: BaseRouterProtocol {
    
}

protocol AddVoiceNoteInteractorInputProtocol: BaseInteractorInputProtocol {
    var presenter: AddVoiceNoteInteractorOutputProtocol? { get set }
    
    var userToken: String? { get }
    func addOrderComment(addOrderCommentRequest: AddOrderCommentRequest, attachments: [String: [Data]], body: [String: Any])
}

protocol AddVoiceNoteInteractorOutputProtocol: BaseInteractorOutputProtocol {
    func fetchingAddVoiceNoteWithSuccess()
    func fetchingWithError(error: String)
}
