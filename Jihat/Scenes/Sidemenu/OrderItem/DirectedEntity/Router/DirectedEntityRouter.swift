//
//  DirectedEntityRouter.swift
//  Jihat
//
//  Created by Peter Bassem on 20/12/2021.
//  Copyright © 2021 Jehat. All rights reserved.
//
//

import UIKit

// MARK: DirectedEntity Router -

class DirectedEntityRouter: BaseRouter, DirectedEntityRouterProtocol {
    
    static func createModule(departments: [DepartmentsResponse], departmentSelection: @escaping DepartmentSelection) -> UIViewController {
        let view =  DirectedEntityTableViewController()

        let interactor = DirectedEntityInteractor()
        let router = DirectedEntityRouter()
        let presenter = DirectedEntityPresenter(view: view, interactor: interactor, router: router, departments: departments, departmentSelection: departmentSelection)
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        return view
    }

    func dismissDirectedEntityViewController() {
        if let directedEntitiyViewController = viewController as? DirectedEntityTableViewController {
            directedEntitiyViewController.dismiss(animated: true)
        }
    }
}
