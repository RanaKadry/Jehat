//
//  DepartmentSelectorRouter.swift
//  Jihat
//
//  Created by Peter Bassem on 20/12/2021.
//  Copyright © 2021 Jehat. All rights reserved.
//
//

import UIKit

// MARK: DepartmentSelector Router -

class DepartmentSelectorRouter: BaseRouter, DepartmentSelectorRouterProtocol {
    
    static func createModule(departments: [DepartmentsResponse], departmentSelection: @escaping DepartmentSelection) -> UIViewController {
        let view =  DepartmentSelectorViewController()

        let interactor = DepartmentSelectorInteractor()
        let router = DepartmentSelectorRouter()
        let presenter = DepartmentSelectorPresenter(view: view, interactor: interactor, router: router, departments: departments, departmentSelection: departmentSelection)
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        return view
    }
}
//print(viewController?.presentingViewController)
