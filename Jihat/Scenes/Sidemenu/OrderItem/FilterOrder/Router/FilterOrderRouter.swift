//
//  FilterOrderRouter.swift
//  Jihat
//
//  Created by Peter Bassem on 27/11/2021.
//  Copyright © 2021 Jehat. All rights reserved.
//
//

import UIKit

// MARK: FilterOrder Router -

class FilterOrderRouter: BaseRouter, FilterOrderRouterProtocol {
    
    static func createModule(orderFilterItems: [TicketFilterItemsResponse], filterOrderCompletion: FilterOrderCompletion) -> UIViewController {
        let view =  FilterOrderViewController()

        let interactor = FilterOrderInteractor()
        let router = FilterOrderRouter()
        let presenter = FilterOrderPresenter(view: view, interactor: interactor, router: router, orderFilterItems: orderFilterItems, filterOrderCompletion: filterOrderCompletion)
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        return view
    }

}
