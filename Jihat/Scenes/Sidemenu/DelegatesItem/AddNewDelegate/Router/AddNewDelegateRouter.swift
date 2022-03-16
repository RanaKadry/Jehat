//
//  AddNewDelegateRouter.swift
//  Jihat
//
//  Created Ahmed Barghash on 02/10/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

// MARK: AddNewDelegate Router -

class AddNewDelegateRouter: BaseRouter ,AddNewDelegateRouterProtocol {
        
    static func createModule(withType type: DelegateOperationsType, newDelegateAdded: ActionCompletion?) -> UIViewController {
        let view =  AddNewDelegateViewController()

        let interactor = AddNewDelegateInteractor(
            useCase: AddDelegateUseCase(
                commissionerRepository: CommissionerRepositoryImp(),
                userRepository: UserRepositoryImp()
            ),
            singleUseCase: SingleDelegateUseCase(
                commissionerRepository: CommissionerRepositoryImp(),
                userRepository: UserRepositoryImp())
        )
        let router = AddNewDelegateRouter()
        let presenter = AddNewDelegatePresenter(view: view, interactor: interactor, router: router, type: type, newDelegateAdded: newDelegateAdded)
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        return view
    }

}
