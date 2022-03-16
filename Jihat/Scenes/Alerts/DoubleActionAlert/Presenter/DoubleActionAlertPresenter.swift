//
//  DoubleActionAlertPresenter.swift
//  Jihat
//
//  Created Peter Bassem on 23/10/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

// MARK: DoubleActionAlert Presenter -

class DoubleActionAlertPresenter: BasePresenter {

    weak var view: DoubleActionAlertViewProtocol?
    private let interactor: DoubleActionAlertInteractorInputProtocol
    private let router: DoubleActionAlertRouterProtocol
    
    private let alertImage: String
    private let alertTitle: String
    private let alertMessage: String
    private let alertPrimaryActionTitle: String
    private var alertPrimaryActionTitleColor: String?
    private var alertPrimaryActionBackgroundColor: String?
    private var alertPrimaryActionCompletion: ActionCompletion
    private let alertSecondaryActionTitle: String
    private var alertSecondaryActionTitleColor: String?
    private var alertSecondaryActionBackgroundColor: String?
    private var alertSecondaryActionCompletion: ActionCompletion
    
    init(view: DoubleActionAlertViewProtocol, interactor: DoubleActionAlertInteractorInputProtocol, router: DoubleActionAlertRouterProtocol, alertImage: String, alertTitle: String, alertMessage: String, alertPrimaryActionTitle: String, alertPrimaryActionTitleColor: String?, alertPrimaryActionBackgroundColor: String?, alertPrimaryActionCompletion: @escaping ActionCompletion, alertSecondaryActionTitle: String, alertSecondaryActionTitleColor: String?, alertSecondaryActionBackgroundColor: String?, alertSecondaryActionCompletion: @escaping ActionCompletion) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.alertImage = alertImage
        self.alertTitle = alertTitle
        self.alertMessage = alertMessage
        self.alertPrimaryActionTitle = alertPrimaryActionTitle
        self.alertPrimaryActionTitleColor = alertPrimaryActionTitleColor
        self.alertPrimaryActionBackgroundColor = alertPrimaryActionBackgroundColor
        self.alertPrimaryActionCompletion = alertPrimaryActionCompletion
        self.alertSecondaryActionTitle = alertSecondaryActionTitle
        self.alertSecondaryActionTitleColor = alertSecondaryActionTitleColor
        self.alertSecondaryActionBackgroundColor = alertSecondaryActionBackgroundColor
        self.alertSecondaryActionCompletion = alertSecondaryActionCompletion
    }
}

// MARK: - DoubleActionAlertPresenterProtocol
extension DoubleActionAlertPresenter: DoubleActionAlertPresenterProtocol {
    
    func viewDidLoad() {
        view?.set(alertImage: alertImage)
        view?.set(alertTitle: alertTitle)
        view?.set(alertMessage: alertMessage)
        view?.set(alertPrimaryActionTitle: alertPrimaryActionTitle)
        view?.set(alertPrimaryActionTitleColor: alertPrimaryActionTitleColor)
        view?.set(alertPrimaryActionBackgroundColor: alertPrimaryActionBackgroundColor)
        view?.set(alertSecondaryActionTitle: alertSecondaryActionTitle)
        view?.set(alertSecondaryActionTitleColor: alertSecondaryActionTitleColor)
        view?.set(alertSecondaryActionBackgroundColor: alertSecondaryActionBackgroundColor)
    }
}

// MARK: - API
extension DoubleActionAlertPresenter: DoubleActionAlertInteractorOutputProtocol {
    
}

// MARK: - Selectors
extension DoubleActionAlertPresenter {
    func primaryActionButtonPressed() {
        alertPrimaryActionCompletion()
    }
    
    func secondaryActionButtonPressed() {
        alertSecondaryActionCompletion()
    }
}
