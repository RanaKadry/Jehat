//
//  OrderDetailsTypeRouter.swift
//  Jihat
//
//  Created Peter Bassem on 30/09/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

// MARK: OrderDetailsType Router -

class OrderDetailsTypeRouter: BaseRouter, OrderDetailsTypeRouterProtocol {
    
    static func createModule(order: UserOrdersResponse) -> UIViewController {
        let view =  OrderDetailsTypeViewController()

        let interactor = OrderDetailsTypeInteractor()
        let router = OrderDetailsTypeRouter()
        let presenter = OrderDetailsTypePresenter(view: view, interactor: interactor, router: router, order: order)
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        return view
    }

}
