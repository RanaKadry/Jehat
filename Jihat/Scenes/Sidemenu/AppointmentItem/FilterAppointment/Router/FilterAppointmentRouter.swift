//
//  FilterAppointmentRouter.swift
//  Jihat
//
//  Created by Peter Bassem on 20/11/2021.
//  Copyright © 2021 Jehat. All rights reserved.
//
//

import UIKit

// MARK: FilterAppointment Router -

class FilterAppointmentRouter: BaseRouter, FilterAppointmentRouterProtocol {
    
    static func createModule(filterAppointmentCompletion: FilterAppointmentCompletion) -> UIViewController {
        let view =  FilterAppointmentViewController()

        let interactor = FilterAppointmentInteractor()
        let router = FilterAppointmentRouter()
        let presenter = FilterAppointmentPresenter(view: view, interactor: interactor, router: router, filterAppointmentCompletion: filterAppointmentCompletion)
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        return view
    }

}
