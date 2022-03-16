//
//  AddAttachmentsRouter.swift
//  Jihat
//
//  Created by Peter Bassem on 03/12/2021.
//  Copyright © 2021 Jehat. All rights reserved.
//
//

import UIKit

// MARK: AddAttachments Router -

class AddAttachmentsRouter: BaseRouter, AddAttachmentsRouterProtocol {
    
    static func createModule(orderId: String?, addAttachmentsCompletion: @escaping ActionCompletion) -> UIViewController {
        let view =  AddAttachmentsViewController()

        let interactor = AddAttachmentsInteractor(
            useCase: OrderAddAttachmentUseCase(
                userRepository: UserRepositoryImp(),
                orderRepository: OrderRepositoryImp()
            )
        )
        let router = AddAttachmentsRouter()
        let presenter = AddAttachmentsPresenter(view: view, interactor: interactor, router: router, orderId: orderId, addAttachmentsCompletion: addAttachmentsCompletion)
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        return view
    }

}
