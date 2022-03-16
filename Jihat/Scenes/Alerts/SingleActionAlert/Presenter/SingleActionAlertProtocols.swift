//
//  SingleActionAlertProtocols.swift
//  Jihat
//
//  Created Peter Bassem on 22/10/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

// MARK: SingleActionAlert Protocols

protocol SingleActionAlertViewProtocol: BaseViewProtocol {
    var presenter: SingleActionAlertPresenterProtocol! { get set }
    
    func set(alertImage: String)
    func set(alertTitle: String)
    func set(alertMessage: String)
    func set(alertActionTitle: String)
    func set(alertActionTitleColor: String?)
    func set(alertActionBackgroundColor: String?)
}

protocol SingleActionAlertPresenterProtocol: BasePresenterProtocol {
    var view: SingleActionAlertViewProtocol? { get set }
    
    func viewDidLoad()

    func alertActionButtonPressed()
}

protocol SingleActionAlertRouterProtocol: BaseRouterProtocol {
    
}

protocol SingleActionAlertInteractorInputProtocol: BaseInteractorInputProtocol {
    var presenter: SingleActionAlertInteractorOutputProtocol? { get set }
    
}

protocol SingleActionAlertInteractorOutputProtocol: BaseInteractorOutputProtocol {
    
    
}
