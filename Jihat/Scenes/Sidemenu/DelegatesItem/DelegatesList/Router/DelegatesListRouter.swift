//
//  DelegatesListRouter.swift
//  Jihat
//
//  Created Ahmed Barghash on 02/10/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

// MARK: DelegatesList Router -

class DelegatesListRouter: BaseRouter ,DelegatesListRouterProtocol {
        
    static func createModule() -> UIViewController {
        let view =  DelegatesListViewController()

        let interactor = DelegatesListInteractor(
            useCase: DelegatesUseCase(
                commissionerRepository: CommissionerRepositoryImp(),
                userRepository: UserRepositoryImp()
            )
        )
        let router = DelegatesListRouter()
        let presenter = DelegatesListPresenter(view: view, interactor: interactor, router: router)
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        return view
    }

    func navigateToAddNewDelegateViewController(withType type: DelegateOperationsType, newDelegateAdded: ActionCompletion?) {
        let addNewDelegateViewController = AddNewDelegateRouter.createModule(withType: type, newDelegateAdded: newDelegateAdded)
        viewController?.navigationController?.pushViewController(addNewDelegateViewController, animated: true)
    }
    
    func showShareActivityController(withShareText text: String) {
        let activityViewController = UIActivityViewController(activityItems: [text], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = viewController?.view ?? UIView()
        viewController?.present(activityViewController, animated: true)
    }
}
