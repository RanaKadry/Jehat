//
//  AddTextPresenter.swift
//  Jihat
//
//  Created Peter Bassem on 10/10/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

// MARK: AddText Presenter -

class AddTextPresenter: BasePresenter {

    weak var view: AddTextViewProtocol?
    private let interactor: AddTextInteractorInputProtocol
    private let router: AddTextRouterProtocol
    private let orderId: String?
    private let addTexTCompletion: ActionCompletion
    
    init(view: AddTextViewProtocol, interactor: AddTextInteractorInputProtocol, router: AddTextRouterProtocol, orderId: String?, addTexTCompletion: @escaping ActionCompletion) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.orderId = orderId
        self.addTexTCompletion = addTexTCompletion
    }
}

// MARK: - AddTextPresenterProtocol
extension AddTextPresenter: AddTextPresenterProtocol {
    
    func viewDidLoad() {
        
    }
    
    func performValidateTextNote(empty: Bool) {
        empty ? view?.hideSaveButton() : view?.showSaveButton()
    }
}

// MARK: - API
extension AddTextPresenter: AddTextInteractorOutputProtocol {
    
    func fetchingAddCommentWithSuccess() {
        addTexTCompletion()
        router.dismissViewController()
    }
    
    
    func fetchingWithError(error: String) {
        view?.showBottomMessage(error)
    }
}

// MARK: - Selectors
extension AddTextPresenter {
    
    func performBack() {
        router.dismissViewController()
    }
    
    func performSaveButtonPressed(note: String?) {
        interactor.addOrderComment(addOrderCommentRequest: AddOrderCommentRequest(userToken: interactor.userToken, orderId: orderId, comment: note))
    }
}
