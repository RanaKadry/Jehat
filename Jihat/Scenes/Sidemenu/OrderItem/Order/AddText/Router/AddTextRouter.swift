//
//  AddTextRouter.swift
//  Jihat
//
//  Created Peter Bassem on 10/10/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

// MARK: AddText Router -

class AddTextRouter: BaseRouter, AddTextRouterProtocol {
    
    static func createModule(orderId: String?, addTexTCompletion: @escaping ActionCompletion) -> UIViewController {
        let view =  AddTextViewController()

        let interactor = AddTextInteractor(
            useCase: OrderAddTextUseCase(
                userRepository: UserRepositoryImp(),
                orderRepository: OrderRepositoryImp()
            )
        )
        let router = AddTextRouter()
        let presenter = AddTextPresenter(view: view, interactor: interactor, router: router, orderId: orderId, addTexTCompletion: addTexTCompletion)
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        return view
    }
}
