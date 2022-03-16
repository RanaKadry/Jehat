//
//  AddNewDocumentsRouter.swift
//  Jihat
//
//  Created Ahmed Barghash on 12/10/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

// MARK: AddNewDocuments Router -

class AddNewDocumentsRouter: BaseRouter, AddNewDocumentsRouterProtocol {
        
    static func createModule(successAddDocumentCompletion: @escaping ActionCompletion) -> UIViewController {
        let view =  AddNewDocumentsViewController()

        let interactor = AddNewDocumentsInteractor(
            useCase: AddDocumentUseCase(
                userRepository: UserRepositoryImp(), documentRepository: DocumentRepositoryImp()
            )
        )
        let router = AddNewDocumentsRouter()
        let presenter = AddNewDocumentsPresenter(view: view, interactor: interactor, router: router, successAddDocumentCompletion: successAddDocumentCompletion)
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        return view
    }
    
    func navigateToLoginViewController() {
        let loginViewController = UINavigationController(rootViewController: LoginRouter.createModule())
        keyWindow?.rootViewController = loginViewController
    }

}
