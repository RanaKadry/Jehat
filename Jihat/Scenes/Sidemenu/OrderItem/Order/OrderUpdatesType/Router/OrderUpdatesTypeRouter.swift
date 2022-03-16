//
//  OrderUpdatesTypeRouter.swift
//  Jihat
//
//  Created Peter Bassem on 30/09/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

// MARK: OrderUpdatesType Router -

class OrderUpdatesTypeRouter: BaseRouter, OrderUpdatesTypeRouterProtocol {
    
    static func createModule(orderComments: [UserOrderCommentsResponse], addTextAction: @escaping ActionCompletion, addVoiceNoteAction: @escaping ActionCompletion, addAttachmentAction: @escaping ActionCompletion) -> UIViewController {
        let view =  OrderUpdatesTypeViewController()

        let interactor = OrderUpdatesTypeInteractor(
            useCase: OrderUpdatesUseCase(
                userRepoistory: UserRepositoryImp(),
                orderRepository: OrderRepositoryImp(),
                documentRepository: DocumentRepositoryImp()
            )
        )
        let router = OrderUpdatesTypeRouter()
        let presenter = OrderUpdatesTypePresenter(view: view, interactor: interactor, router: router, orderComments: orderComments, addTextAction: addTextAction, addVoiceNoteAction: addVoiceNoteAction, addAttachmentAction: addAttachmentAction)
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        return view
    }

}
