//
//  NewAppointmentRouter.swift
//  Jihat
//
//  Created Ahmed Barghash on 30/09/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

// MARK: NewAppointment Router -

class NewAppointmentRouter: BaseRouter,NewAppointmentRouterProtocol {
        
    static func createModule(addAppointmentCompletion: @escaping ActionCompletion) -> UIViewController {
        let view =  NewAppointmentViewController()

        let interactor = NewAppointmentInteractor(
            useCase: AddAppointmentUseCase(
                userRepository: UserRepositoryImp(),
                appointmentRepository: AppointmentRepoistoryImp()
            )
        )
        let router = NewAppointmentRouter()
        let presenter = NewAppointmentPresenter(view: view, interactor: interactor, router: router, addAppointmentCompletion: addAppointmentCompletion)
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        return view
    }
    
    func navigateToLoginViewController() {
        let loginViewController = UINavigationController(rootViewController: LoginRouter.createModule())
        keyWindow?.rootViewController = loginViewController
    }
}
