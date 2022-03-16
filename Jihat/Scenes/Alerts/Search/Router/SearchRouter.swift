//
//  SearchRouter.swift
//  Jihat
//
//  Created by Peter Bassem on 05/03/2022.
//  Copyright © 2022 Jehat. All rights reserved.
//
//

import UIKit

// MARK: Search Router -

class SearchRouter<T: Codable>: BaseRouter, SearchRouterProtocol {
    
    static func createModule(searchItems: [T], searchItemSelection: @escaping SearchItemSelection<T>) -> UIViewController {
        let view =  SearchViewController()

        let interactor = SearchInteractor()
        let router = SearchRouter()
        let presenter = SearchPresenter(view: view, interactor: interactor, router: router, searchItems: searchItems, searchItemSelection: searchItemSelection)
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        return view
    }

}
