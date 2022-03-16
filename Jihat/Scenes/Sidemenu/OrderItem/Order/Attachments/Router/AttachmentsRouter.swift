//
//  AttachmentsRouter.swift
//  Jihat
//
//  Created Peter Bassem on 09/10/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

// MARK: Attachments Router -

class AttachmentsRouter: BaseRouter, AttachmentsRouterProtocol {
    
    static func createModule(attachments: [String], attachmentSelection: @escaping AttachmentSelection) -> UIViewController {
        let view =  AttachmentsCollectionViewController()

        let interactor = AttachmentsInteractor()
        let router = AttachmentsRouter()
        let presenter = AttachmentsPresenter(view: view, interactor: interactor, router: router, attachments: attachments, attachmentSelection: attachmentSelection)
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        return view
    }
}
