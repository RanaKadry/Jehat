//
//  AddTextProtocols.swift
//  Jihat
//
//  Created Peter Bassem on 10/10/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

// MARK: AddText Protocols

protocol AddTextViewProtocol: BaseViewProtocol {
    var presenter: AddTextPresenterProtocol! { get set }
    
    func showSaveButton()
    func hideSaveButton()
}

protocol AddTextPresenterProtocol: BasePresenterProtocol {
    var view: AddTextViewProtocol? { get set }
    
    func viewDidLoad()

    func performBack()
    func performValidateTextNote(empty: Bool)
    
    func performSaveButtonPressed(note: String?)
}

protocol AddTextRouterProtocol: BaseRouterProtocol {
    
}

protocol AddTextInteractorInputProtocol: BaseInteractorInputProtocol {
    var presenter: AddTextInteractorOutputProtocol? { get set }
    
    var userToken: String? { get }
    func addOrderComment(addOrderCommentRequest: AddOrderCommentRequest)
}

protocol AddTextInteractorOutputProtocol: BaseInteractorOutputProtocol {
    func fetchingAddCommentWithSuccess()
    func fetchingWithError(error: String)
}
