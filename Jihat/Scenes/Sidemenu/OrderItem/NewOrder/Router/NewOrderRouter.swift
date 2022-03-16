//
//  NewOrderRouter.swift
//  Jihat
//
//  Created Ahmed Barghash on 28/09/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

// MARK: NewOrder Router -

class NewOrderRouter: BaseRouter,NewOrderRouterProtocol {
    
    private var dismissNewOrderViewController: UIViewController?
    private var addOrderSuccessfullyViewController: UIViewController?
        
    static func createModule(addOrderCompletion: @escaping ActionCompletion) -> UIViewController {
        let view =  NewOrderViewController()

        let interactor = NewOrderInteractor(
            useCase: NewOrderUseCase(
                orderRepository: OrderRepositoryImp(),
                userRepository: UserRepositoryImp()
            )
        )
        let router = NewOrderRouter()
        let presenter = NewOrderPresenter(view: view, interactor: interactor, router: router, addOrderCompletion: addOrderCompletion)
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        return view
    }

    func presentDismissNewOrderViewController(alertPrimaryActionCompletion: @escaping ActionCompletion, alertSecondaryActionCompletion: @escaping ActionCompletion) {
        dismissNewOrderViewController = DoubleActionAlertRouter.createModule(alertImage: DesignSystem.Icon.addOrderCancelAlert.rawValue, alertTitle: "are_you_sure".localized(), alertMessage: "dismiss_message".localized(), alertPrimaryActionTitle: "yes".localized(), alertPrimaryActionTitleColor: DesignSystem.Colors.text6Color.rawValue, alertPrimaryActionBackgroundColor: DesignSystem.Colors.action3Color.rawValue, alertPrimaryActionCompletion: alertPrimaryActionCompletion, alertSecondaryActionTitle: "cancel".localized(), alertSecondaryActionTitleColor: DesignSystem.Colors.text1Color.rawValue, alertSecondaryActionBackgroundColor: DesignSystem.Colors.primaryActionColor.rawValue, alertSecondaryActionCompletion: alertSecondaryActionCompletion)
        dismissNewOrderViewController?.modalPresentationStyle = .overFullScreen
        viewController?.present(dismissNewOrderViewController!, animated: true, completion: nil)
    }
    
    func dismissDismissNewOrderViewController() {
        dismissNewOrderViewController?.dismiss(animated: true)
    }
    
    func presentAddOrderSuccessfullyViewController(alertActionCompletion: @escaping ActionCompletion) {
        addOrderSuccessfullyViewController = SingleActionAlertRouter.createModule(alertImage: DesignSystem.Icon.addOrderSuccessfullyAlert.rawValue, alertTitle: "order_added_successfully".localized(), alertMessage: "order_added_successfully_message".localized(), alertActionTitle: "thank_you".localized(), alertActionCompletion: alertActionCompletion)
        addOrderSuccessfullyViewController?.modalPresentationStyle = .overFullScreen
        viewController?.present(addOrderSuccessfullyViewController!, animated: true, completion: nil)
    }
    
    func dismissAddOrderSuccessfullyViewController() {
        addOrderSuccessfullyViewController?.dismiss(animated: true)
    }
    
    func presentDirectedEntitiesViewController(departments: [DepartmentsResponse], departmentSelection: @escaping DepartmentSelection) {
        let direcedEntityViewController = UINavigationController(rootViewController: DepartmentSelectorRouter.createModule(departments: departments, departmentSelection: departmentSelection))
        viewController?.present(direcedEntityViewController, animated: true)
    }
    
    func presentOrderTypeViewController(transactionTypes: [TransactionTypesResponse], transactionSelection: @escaping SearchItemSelection<TransactionTypesResponse>) {
        let orderTypeViewController = UINavigationController(rootViewController: SearchRouter.createModule(searchItems: transactionTypes, searchItemSelection: transactionSelection))
        viewController?.present(orderTypeViewController, animated: true)
    }
    
    func navigateToLoginViewController() {
        let loginViewController = UINavigationController(rootViewController: LoginRouter.createModule())
        keyWindow?.rootViewController = loginViewController
    }
}
