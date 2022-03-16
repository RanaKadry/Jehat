//
//  SingleActionAlertPresenter.swift
//  Jihat
//
//  Created Peter Bassem on 22/10/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

// MARK: SingleActionAlert Presenter -

class SingleActionAlertPresenter: BasePresenter {

    weak var view: SingleActionAlertViewProtocol?
    private let interactor: SingleActionAlertInteractorInputProtocol
    private let router: SingleActionAlertRouterProtocol
    
    private let alertImage: String
    private let alertTitle: String
    private let alertMessage: String
    private let alertActionTitle: String
    private var alertActionTitleColor: String?
    private var alertActionBackgroundColor: String?
    private var alertActionCompletion: ActionCompletion
    
    init(view: SingleActionAlertViewProtocol, interactor: SingleActionAlertInteractorInputProtocol, router: SingleActionAlertRouterProtocol, alertImage: String, alertTitle: String, alertMessage: String, alertActionTitle: String, alertActionTitleColor: String?, alertActionBackgroundColor: String?, alertActionCompletion: @escaping ActionCompletion) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.alertImage = alertImage
        self.alertTitle = alertTitle
        self.alertMessage = alertMessage
        self.alertActionTitle = alertActionTitle
        self.alertActionTitleColor = alertActionTitleColor
        self.alertActionBackgroundColor = alertActionBackgroundColor
        self.alertActionCompletion = alertActionCompletion
    }
}

// MARK: - SingleActionAlertPresenterProtocol
extension SingleActionAlertPresenter: SingleActionAlertPresenterProtocol {
    
    func viewDidLoad() {
        view?.set(alertImage: alertImage)
        view?.set(alertTitle: alertTitle)
        view?.set(alertMessage: alertMessage)
        view?.set(alertActionTitle: alertActionTitle)
        view?.set(alertActionTitleColor: alertActionTitleColor)
        view?.set(alertActionBackgroundColor: alertActionBackgroundColor)
    }
}

// MARK: - API
extension SingleActionAlertPresenter: SingleActionAlertInteractorOutputProtocol {
    
}

// MARK: - Selectors
extension SingleActionAlertPresenter {
    
    func alertActionButtonPressed() {
        alertActionCompletion()
    }
}
