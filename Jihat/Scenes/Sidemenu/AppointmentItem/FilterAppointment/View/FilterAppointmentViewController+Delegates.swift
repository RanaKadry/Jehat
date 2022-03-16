//
//  FilterAppointmentViewController+Delegates.swift
//  Jihat
//
//  Created by Peter Bassem on 20/11/2021.
//  Copyright © 2021 Jehat. All rights reserved.
//
//

import UIKit

extension FilterAppointmentViewController: FilterAppointmentViewProtocol {
    
    func display(startDate: String) {
        _filterStartDateTextField.text = startDate
        presenter.performValidateInputs(startDate: _filterStartDateTextField.text, endDate: _filterEndDateTextField.text)
    }
    
    func setEndDatePickerMinimumDate(date: Date) {
        endDatePickerView.minimumDate = date
    }
    
    func enableEndDateTextField() {
        _filterEndDateTextField.isEnabled = true
    }
    
    func display(endDate: String) {
        _filterEndDateTextField.text = endDate
        presenter.performValidateInputs(startDate: _filterStartDateTextField.text, endDate: _filterEndDateTextField.text)
    }
    
    func enableFilterButton() {
        _filterButton.configureButton(true)
    }
    
    func disableFilterButton() {
        _filterButton.configureButton(false)
    }
}
