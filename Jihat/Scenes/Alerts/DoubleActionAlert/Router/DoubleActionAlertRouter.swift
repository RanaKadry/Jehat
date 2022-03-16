//
//  DoubleActionAlertRouter.swift
//  Jihat
//
//  Created Peter Bassem on 23/10/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

// MARK: DoubleActionAlert Router -

class DoubleActionAlertRouter: BaseRouter, DoubleActionAlertRouterProtocol {
    
    static func createModule(alertImage: String, alertTitle: String, alertMessage: String, alertPrimaryActionTitle: String, alertPrimaryActionTitleColor: String? = DesignSystem.Colors.text1Color.rawValue, alertPrimaryActionBackgroundColor: String? = DesignSystem.Colors.primaryActionColor.rawValue, alertPrimaryActionCompletion: @escaping ActionCompletion, alertSecondaryActionTitle: String, alertSecondaryActionTitleColor: String? = DesignSystem.Colors.text2Color.rawValue, alertSecondaryActionBackgroundColor: String? = DesignSystem.Colors.action3Color.rawValue, alertSecondaryActionCompletion: @escaping ActionCompletion) -> UIViewController {
        let view =  DoubleActionAlertViewController()

        let interactor = DoubleActionAlertInteractor()
        let router = DoubleActionAlertRouter()
        let presenter = DoubleActionAlertPresenter(view: view, interactor: interactor, router: router, alertImage: alertImage, alertTitle: alertTitle, alertMessage: alertMessage, alertPrimaryActionTitle: alertPrimaryActionTitle, alertPrimaryActionTitleColor: alertPrimaryActionTitleColor, alertPrimaryActionBackgroundColor: alertPrimaryActionBackgroundColor, alertPrimaryActionCompletion: alertPrimaryActionCompletion, alertSecondaryActionTitle: alertSecondaryActionTitle, alertSecondaryActionTitleColor: alertSecondaryActionTitleColor, alertSecondaryActionBackgroundColor: alertSecondaryActionBackgroundColor, alertSecondaryActionCompletion: alertSecondaryActionCompletion)
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        return view
    }

}
