//
//  SingleActionAlertRouter.swift
//  Jihat
//
//  Created Peter Bassem on 22/10/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

// MARK: SingleActionAlert Router -

class SingleActionAlertRouter: BaseRouter, SingleActionAlertRouterProtocol {
    
    static func createModule(alertImage: String, alertTitle: String, alertMessage: String, alertActionTitle: String, alertActionTitleColor: String? = DesignSystem.Colors.text1Color.rawValue, alertActionBackgroundColor: String? = DesignSystem.Colors.primaryActionColor.rawValue, alertActionCompletion: @escaping ActionCompletion) -> UIViewController {
        let view =  SingleActionAlertViewController()

        let interactor = SingleActionAlertInteractor()
        let router = SingleActionAlertRouter()
        let presenter = SingleActionAlertPresenter(view: view, interactor: interactor, router: router, alertImage: alertImage, alertTitle: alertTitle, alertMessage: alertMessage, alertActionTitle: alertActionTitle, alertActionTitleColor: alertActionTitleColor, alertActionBackgroundColor: alertActionBackgroundColor, alertActionCompletion: alertActionCompletion)
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        return view
    }

}
