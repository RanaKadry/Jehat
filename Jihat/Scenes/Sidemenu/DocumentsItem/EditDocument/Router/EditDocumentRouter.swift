//
//  EditDocumentRouter.swift
//  Jihat
//
//  Created Ahmed Barghash on 13/10/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

// MARK: EditDocument Router -

class EditDocumentRouter: BaseRouter,EditDocumentRouterProtocol {
        
    static func createModule(withDocumentId documentId: String, atIndex index: Int, updateDocumentCompletion: @escaping UpdateDocumentCompletion) -> UIViewController {
        let view =  EditDocumentViewController()

        let interactor = EditDocumentInteractor(
            useCase: EditDocumentUseCase(
                userRepoistory: UserRepositoryImp(),
                documentRepository: DocumentRepositoryImp()
            )
        )
        let router = EditDocumentRouter()
        let presenter = EditDocumentPresenter(view: view, interactor: interactor, router: router, documentId: documentId, index: index, updateDocumentCompletion: updateDocumentCompletion)
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        return view
    }
}
