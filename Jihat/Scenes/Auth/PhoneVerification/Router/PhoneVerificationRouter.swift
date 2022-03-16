//
//  PhoneVerificationRouter.swift
//  Jihat
//
//  Created Peter Bassem on 18/09/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

// MARK: PhoneVerification Router -

class PhoneVerificationRouter: BaseRouter, PhoneVerificationRouterProtocol {
    
    static func createModule() -> UIViewController {
        let view =  PhoneVerificationViewController()

        let interactor = PhoneVerificationInteractor(
            useCase: PhoneVerificationUseCase(
                userRepository: UserRepositoryImp()
            )
        )
        let router = PhoneVerificationRouter()
        let presenter = PhoneVerificationPresenter(view: view, interactor: interactor, router: router)
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        return view
    }
    
    func presentRegisterSuccessfullyViewController(alertActionCompletion: @escaping ActionCompletion) {
        let successfullRegisterViewController = SingleActionAlertRouter.createModule(alertImage: DesignSystem.Icon.registerSuccessfully.rawValue, alertTitle: "order_added_successfully".localized(), alertMessage: "you_can_use_app".localized(), alertActionTitle: "thank_you".localized(), alertActionCompletion: alertActionCompletion)
        successfullRegisterViewController.modalPresentationStyle = .overFullScreen
        viewController?.present(successfullRegisterViewController, animated: true, completion: nil)
    }
    
    func navigateToLoginViewController() {
        let homeViewController = UINavigationController(rootViewController: LoginRouter.createModule())
        keyWindow?.rootViewController = homeViewController
    }
}
