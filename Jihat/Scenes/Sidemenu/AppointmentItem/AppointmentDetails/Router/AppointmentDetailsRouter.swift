//
//  AppointmentDetailsRouter.swift
//  Jihat
//
//  Created Ahmed Barghash on 28/10/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

// MARK: AppointmentDetails Router -

class AppointmentDetailsRouter: BaseRouter,AppointmentDetailsRouterProtocol {
        
    static func createModule(appointmentId: String?) -> UIViewController {
        let view =  AppointmentDetailsViewController()

        let interactor = AppointmentDetailsInteractor(
            useCase: AppointmentDetailsUseCase(
                userRepository: UserRepositoryImp(),
                appointmentRepository: AppointmentRepoistoryImp(),
                documentRepository: DocumentRepositoryImp()
            )
        )
        let router = AppointmentDetailsRouter()
        let presenter = AppointmentDetailsPresenter(view: view, interactor: interactor, router: router, appointmentId: appointmentId)
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        return view
    }

}
