//
//  ProfileRouter.swift
//  Jihat
//
//  Created Ahmed Barghash on 25/09/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

// MARK: Profile Router -

class ProfileRouter: BaseRouter,ProfileRouterProtocol {
    
    static func createModule(updateProfileCompletion: UpdateProfileCompletion) -> UIViewController {
        let view =  ProfileViewController()

        let interactor = ProfileInteractor(
            useCase: ProfileUseCase(
                userRepository: UserRepositoryImp()
            )
        )
        let router = ProfileRouter()
        let presenter = ProfilePresenter(view: view, interactor: interactor, router: router, updateProfileCompletion: updateProfileCompletion)
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        return view
    }

}
