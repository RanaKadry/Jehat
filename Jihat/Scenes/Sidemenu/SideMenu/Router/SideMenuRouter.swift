//
//  SideMenuRouter.swift
//  Jihat
//
//  Created Peter Bassem on 22/09/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

// MARK: SideMenu Router -

class SideMenuRouter: BaseRouter, SideMenuRouterProtocol {
    
    static func createModule(user: UserDataResponse, profileButtonPressed: @escaping ActionCompletion, didSelectMenuItem: @escaping SideMenuSelectionItem) -> UIViewController {
        let view =  SideMenuViewController()

        let interactor = SideMenuInteractor(
            useCase: SideMenuUseCase(
                userRepository: UserRepositoryImp()
            )
        )
        let router = SideMenuRouter()
        let presenter = SideMenuPresenter(view: view, interactor: interactor, router: router, user: user, profileButtonPressed: profileButtonPressed, didSelectItem: didSelectMenuItem)
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        return view
    }
}
