//
//  AddVoiceNoteRouter.swift
//  Jihat
//
//  Created Peter Bassem on 13/10/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

// MARK: AddVoiceNote Router -

class AddVoiceNoteRouter: BaseRouter, AddVoiceNoteRouterProtocol {
    
    static func createModule(orderId: String?, addVoiceNoteCompletion: @escaping ActionCompletion) -> UIViewController {
        let view =  AddVoiceNoteViewController()

        let interactor = AddVoiceNoteInteractor(
            useCase: AddVoiceNoteUseCase(
                userRepository: UserRepositoryImp(),
                orderRepository: OrderRepositoryImp()
            )
        )
        let router = AddVoiceNoteRouter()
        let presenter = AddVoiceNotePresenter(view: view, interactor: interactor, router: router, orderId: orderId, addVoiceNoteCompletion: addVoiceNoteCompletion)
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        return view
    }

}
