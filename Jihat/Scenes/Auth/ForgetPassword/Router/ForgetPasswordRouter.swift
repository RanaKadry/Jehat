//
//  ForgetPasswordRouter.swift
//  Jihat
//
//  Created Peter Bassem on 26/10/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

// MARK: ForgetPassword Router -

class ForgetPasswordRouter: BaseRouter, ForgetPasswordRouterProtocol {
    
    static func createModule() -> UIViewController {
        let view =  ForgetPasswordViewController()

        let interactor = ForgetPasswordInteractor(
            useCase: ForgetPasswordUseCase(
                userRepository: UserRepositoryImp()
            )
        )
        let router = ForgetPasswordRouter()
        let presenter = ForgetPasswordPresenter(view: view, interactor: interactor, router: router)
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        return view
    }

}
