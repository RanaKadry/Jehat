//
//  AddVoiceNotePresenter.swift
//  Jihat
//
//  Created Peter Bassem on 13/10/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

// MARK: AddVoiceNote Presenter -

class AddVoiceNotePresenter: BasePresenter {

    weak var view: AddVoiceNoteViewProtocol?
    private let interactor: AddVoiceNoteInteractorInputProtocol
    private let router: AddVoiceNoteRouterProtocol
    private let orderId: String?
    private let addVoiceNoteCompletion: ActionCompletion
    
    init(view: AddVoiceNoteViewProtocol, interactor: AddVoiceNoteInteractorInputProtocol, router: AddVoiceNoteRouterProtocol, orderId: String?, addVoiceNoteCompletion: @escaping ActionCompletion) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.orderId = orderId
        self.addVoiceNoteCompletion = addVoiceNoteCompletion
    }
}

// MARK: - AddVoiceNotePresenterProtocol
extension AddVoiceNotePresenter: AddVoiceNotePresenterProtocol {
    
    func viewDidLoad() {
        
    }
}

// MARK: - API
extension AddVoiceNotePresenter: AddVoiceNoteInteractorOutputProtocol {
    
    func fetchingAddVoiceNoteWithSuccess() {
        addVoiceNoteCompletion()
        view?.hideLoadingOnSaveButton()
        router.dismissViewController()
    }
    
    func fetchingWithError(error: String) {
        view?.hideLoadingOnSaveButton()
        view?.showBottomMessage(error)
    }
}

// MARK: - Selectors
extension AddVoiceNotePresenter {
    
    func performBack() {
        router.dismissViewController()
    }
    
    func performFinishRecording() {
        view?.showSaveButton()
        view?.showResetButton()
    }
    
    func performResetRecording() {
        view?.hideSaveButton()
        view?.hideResetButton()
    }
    
    func performShowResetButton() {
        view?.showResetButton()
    }
    
    func performHideResetButton() {
        view?.hideResetButton()
    }
    
    func performCancelButton() {
        router.dismissViewController()
    }
    
    func performSaveButton(comment: String?, audioURL: URL?) {
        let sendComment = comment == "add_comment".localized() ? "-" : comment
        let fileURLWithPath = URL(fileURLWithPath: audioURL!.absoluteString)
        do {
            let audioData = try Data(contentsOf: fileURLWithPath)
            let addOrderCommentRequest = AddOrderCommentRequest(userToken: interactor.userToken, orderId: orderId, comment: sendComment)
            view?.showLoadingOnSaveButton()
            interactor.addOrderComment(addOrderCommentRequest: addOrderCommentRequest, attachments: [audioURL!.absoluteString: [audioData]], body: [:])
        } catch {
            print("audio data data converter failed:", error)
        }
    }
}
