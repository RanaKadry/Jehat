//
//  LoginRouter.swift
//  Jihat
//
//  Created Peter Bassem on 15/09/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

// MARK: Login Router -

class LoginRouter: BaseRouter, LoginRouterProtocol {
    
    static func createModule() -> UIViewController {
        let view =  LoginViewController()

        let interactor = LoginInteractor(
            useCase: LoginUseCase(
                sponsersRepository: SponserRepositoryImp(),
                userRepository: UserRepositoryImp()
            )
        )
        let router = LoginRouter()
        let presenter = LoginPresenter(view: view, interactor: interactor, router: router)
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        return view
    }
    
    func navigateToHomeViewController() {
        let homeViewController = UINavigationController(rootViewController: HomeRouter.createModule())
        keyWindow?.rootViewController = homeViewController
    }
    
    func navigateToForgetPasswordViewController() {
        let forgetPasswordViewController = ForgetPasswordRouter.createModule()
        viewController?.navigationController?.pushViewController(forgetPasswordViewController, animated: true)
    }
    
    func navigateToRegisterViewController() {
        let registerViewController = RegisterRouter.createModule()
        viewController?.navigationController?.pushViewController(registerViewController, animated: true)
    }
}
