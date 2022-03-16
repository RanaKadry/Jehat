//
//  RegisterRouter.swift
//  Jihat
//
//  Created Peter Bassem on 17/09/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

// MARK: Register Router -

class RegisterRouter: BaseRouter, RegisterRouterProtocol {
    
    static func createModule() -> UIViewController {
        let view =  RegisterViewController()

        let interactor = RegisterInteractor(
            useCase: RegisterUseCase(
                userRepository: UserRepositoryImp()
            )
        )
        let router = RegisterRouter()
        let presenter = RegisterPresenter(view: view, interactor: interactor, router: router)
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        return view
    }
    
    func presentNationalitiesViewController(countries: [CountriesModel], searchItemSelection: @escaping SearchItemSelection<CountriesModel>) {
        let nationalitiesViewController = UINavigationController(rootViewController: SearchRouter.createModule(searchItems: countries, searchItemSelection: searchItemSelection))
        viewController?.present(nationalitiesViewController, animated: true)
    }
    
    func navigateToPhoneVerificationViewController() {
        let phoneVerificationViewController = PhoneVerificationRouter.createModule()
        viewController?.navigationController?.pushViewController(phoneVerificationViewController, animated: true)
    }
}
