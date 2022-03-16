//
//  DocumentsRouter.swift
//  Jihat
//
//  Created Ahmed Barghash on 04/10/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

// MARK: Documents Router -

class DocumentsRouter: BaseRouter ,DocumentsRouterProtocol {
        
    static func createModule() -> UIViewController {
        let view =  DocumentsViewController()

        let interactor = DocumentsInteractor(
            useCase: DocumentsUseCase(
                documentRepository: DocumentRepositoryImp(), userRepository: UserRepositoryImp()))
        let router = DocumentsRouter()
        let presenter = DocumentsPresenter(view: view, interactor: interactor, router: router)
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        return view
    }
    
    func navigateToAddNewDocumentViewController(successAddDocumentCompletion: @escaping ActionCompletion) {
        let addNewDocumentViewController = AddNewDocumentsRouter.createModule(successAddDocumentCompletion: successAddDocumentCompletion)
        viewController?.navigationController?.pushViewController(addNewDocumentViewController, animated: true)
    }

    func navigateToEditDocumentViewController(withDocumentId documentId: String, atIndex index: Int, updateDocumentCompletion: @escaping UpdateDocumentCompletion) {
        let editDocumentViewController = EditDocumentRouter.createModule(withDocumentId: documentId, atIndex: index, updateDocumentCompletion: updateDocumentCompletion)
        viewController?.navigationController?.pushViewController(editDocumentViewController, animated: true)
    }
    
    func showShareActivityController(withShareText text: String) {
        let activityViewController = UIActivityViewController(activityItems: [text], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = viewController?.view ?? UIView()
        viewController?.present(activityViewController, animated: true)
    }
    
}
