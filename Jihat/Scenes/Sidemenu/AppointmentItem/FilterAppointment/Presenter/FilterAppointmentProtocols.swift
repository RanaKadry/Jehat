//
//  FilterAppointmentProtocols.swift
//  Jihat
//
//  Created by Peter Bassem on 20/11/2021.
//  Copyright © 2021 Jehat. All rights reserved.
//
//

import Foundation

// MARK: FilterAppointment Protocols

protocol FilterAppointmentViewProtocol: BaseViewProtocol {
    var presenter: FilterAppointmentPresenterProtocol! { get set }
    
    func display(startDate: String)
    func setEndDatePickerMinimumDate(date: Date)
    func enableEndDateTextField()
    func display(endDate: String)
    func enableFilterButton()
    func disableFilterButton()
}

protocol FilterAppointmentPresenterProtocol: BasePresenterProtocol {
    var view: FilterAppointmentViewProtocol? { get set }
    
    func viewDidLoad()
    
    func performValidateInputs(startDate: String?, endDate: String?)

    func performContainerViewDidPressed()
    func performSelectStartDate(date: Date)
    func performSelectEndDate(date: Date)
    func filterButtonPressed(startDate: String?, endDate: String?)
    func cancelButtonPressed()
}

protocol FilterAppointmentRouterProtocol: BaseRouterProtocol {
    
}

protocol FilterAppointmentInteractorInputProtocol: BaseInteractorInputProtocol {
    var presenter: FilterAppointmentInteractorOutputProtocol? { get set }
    
}

protocol FilterAppointmentInteractorOutputProtocol: BaseInteractorOutputProtocol {
    
}
