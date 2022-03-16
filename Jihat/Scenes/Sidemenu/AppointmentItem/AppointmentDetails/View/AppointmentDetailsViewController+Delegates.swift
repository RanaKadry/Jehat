//
//  AppointmentDetailsViewController+Delegates.swift
//  Jihat
//
//  Created Ahmed Barghash on 28/10/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

extension AppointmentDetailsViewController: AppointmentDetailsViewProtocol {
    
    func set(appointmentTitle: String) {
        _appointmentTitleLabel.text = appointmentTitle
    }
    
    func set(appointmentDetails: String) {
        _appointmentDetailsLabel.text = appointmentDetails
    }
    
    func set(attachemtsCount: String) {
        _attachedDocumentNumberLabel.text = attachemtsCount
    }
    
    func refreshCollectionView() {
        setupCollectionView()
    }
    
    func set(appointmentDate: String) {
        _appointmentDateLabel.text = appointmentDate
    }
    
    func set(appointmentTime: String) {
        _appointmentTimeLabel.text = appointmentTime
    }
    
    func set(alertType: String) {
        _alertTypeLabel.text = alertType
    }
    
}
