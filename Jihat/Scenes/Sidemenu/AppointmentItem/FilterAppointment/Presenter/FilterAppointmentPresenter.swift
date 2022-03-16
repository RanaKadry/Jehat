//
//  FilterAppointmentPresenter.swift
//  Jihat
//
//  Created by Peter Bassem on 20/11/2021.
//  Copyright © 2021 Jehat. All rights reserved.
//
//

import Foundation

// MARK: FilterAppointment Presenter -

class FilterAppointmentPresenter: BasePresenter {
    
    weak var view: FilterAppointmentViewProtocol?
    private let interactor: FilterAppointmentInteractorInputProtocol
    private let router: FilterAppointmentRouterProtocol
    private let filterAppointmentCompletion: FilterAppointmentCompletion
    
    private var startDate: Date?
    
    init(view: FilterAppointmentViewProtocol, interactor: FilterAppointmentInteractorInputProtocol, router: FilterAppointmentRouterProtocol, filterAppointmentCompletion: FilterAppointmentCompletion) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.filterAppointmentCompletion = filterAppointmentCompletion
    }
}

// MARK: - FilterAppointmentPresenterProtocol
extension FilterAppointmentPresenter: FilterAppointmentPresenterProtocol {
    
    func viewDidLoad() {
        
    }
    
    func performValidateInputs(startDate: String?, endDate: String?) {
        let validateInputs = startDate?.isEmpty == false && endDate?.isEmpty == false
        validateInputs ? view?.enableFilterButton() : view?.disableFilterButton()
    }
}

// MARK: - API
extension FilterAppointmentPresenter: FilterAppointmentInteractorOutputProtocol {
    
}

// MARK: - Selectors
extension FilterAppointmentPresenter {
    
    func performContainerViewDidPressed() {
        router.dismissViewController()
    }
    
    func performSelectStartDate(date: Date) {
        self.startDate = date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormates.daySlashMonthSlashYear.rawValue
        view?.enableEndDateTextField()
        view?.setEndDatePickerMinimumDate(date: date)
        view?.display(startDate: dateFormatter.string(from: date))
    }
    
    func performSelectEndDate(date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormates.daySlashMonthSlashYear.rawValue
        view?.display(endDate: dateFormatter.string(from: date))
    }
    
    func filterButtonPressed(startDate: String?, endDate: String?) {
        filterAppointmentCompletion?(startDate, endDate)
        router.dismissViewController()
    }
    
    func cancelButtonPressed() {
        router.dismissViewController()
    }
}
