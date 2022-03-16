//
//  DoubleActionAlertProtocols.swift
//  Jihat
//
//  Created Peter Bassem on 23/10/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

// MARK: DoubleActionAlert Protocols

protocol DoubleActionAlertViewProtocol: BaseViewProtocol {
    var presenter: DoubleActionAlertPresenterProtocol! { get set }
    
    func set(alertImage: String)
    func set(alertTitle: String)
    func set(alertMessage: String)
    func set(alertPrimaryActionTitle: String)
    func set(alertPrimaryActionTitleColor: String?)
    func set(alertPrimaryActionBackgroundColor: String?)
    func set(alertSecondaryActionTitle: String)
    func set(alertSecondaryActionTitleColor: String?)
    func set(alertSecondaryActionBackgroundColor: String?)
}

protocol DoubleActionAlertPresenterProtocol: BasePresenterProtocol {
    var view: DoubleActionAlertViewProtocol? { get set }
    
    func viewDidLoad()

    func primaryActionButtonPressed()
    func secondaryActionButtonPressed()
}

protocol DoubleActionAlertRouterProtocol: BaseRouterProtocol {
    
}

protocol DoubleActionAlertInteractorInputProtocol: BaseInteractorInputProtocol {
    var presenter: DoubleActionAlertInteractorOutputProtocol? { get set }
    
}

protocol DoubleActionAlertInteractorOutputProtocol: BaseInteractorOutputProtocol {
    
    
}
