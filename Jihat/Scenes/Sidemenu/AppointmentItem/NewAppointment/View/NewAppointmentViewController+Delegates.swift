//
//  NewAppointmentViewController+Delegates.swift
//  Jihat
//
//  Created Ahmed Barghash on 30/09/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

extension NewAppointmentViewController: NewAppointmentViewProtocol {
    
    func setAttachedDocumentsCount(documentsCount: String) {
        _attachedDocumentsTextField.text = documentsCount
    }
    
    func setStartDate(startDate: String) {
        _startDateTextField.text = startDate
    }
    
    func setStartTime(startTime: String) {
        _startTimeTextField.text = startTime
    }
    
    func refreshAlertTypePickerView() {
        setUpAlertTypePickerView()
    }
    
    func displaySelectedAlertType(_ alertType: String) {
        _alertTypeTextField.text = alertType
    }
    
    func enableSaveAppointmentButton() {
        _saveAppointmentButton.configureButton(true)
    }
    
    func disableSaveAppointmentButton() {
        _saveAppointmentButton.configureButton(false)
    }
    
    func startLoadingOnSaveAppointmentButton() {
        _saveAppointmentButton.startAnimation()
    }
    
    func stopLoadingOnSaveAppointmentButton() {
        _saveAppointmentButton.stopAnimation()
    }
}
