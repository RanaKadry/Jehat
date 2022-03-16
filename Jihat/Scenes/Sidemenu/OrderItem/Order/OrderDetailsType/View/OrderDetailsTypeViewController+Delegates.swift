//
//  OrderDetailsTypeViewController+Delegates.swift
//  Jihat
//
//  Created Peter Bassem on 30/09/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

extension OrderDetailsTypeViewController: OrderDetailsTypeViewProtocol {
    
    func refreshScrollView() {
        view.layoutIfNeeded()
    }
    
    func set(orderNumber: String) {
        _orderNumberLabel.text = orderNumber
    }
    
    func set(creationDate: String) {
        _orderCreationDateLabel.text = creationDate
    }
    
    func set(status: String) {
        _orderStatusLabel.text = status
    }
    
    func set(expectedCompletionDate: String) {
        _expectedDateLabel.text = expectedCompletionDate
    }
    
    func set(employee: String) {
        _employeeLabel.text = employee
    }
    
    func set(employeeTextHeight: CGFloat) {
        _employeeLabelHeight.constant = employeeTextHeight
    }
    
    func set(type: String) {
        _typeLabel.text = type
    }
    
    func set(typeTextHeight: CGFloat) {
        _typeLabelHeight.constant = typeTextHeight
    }
    
    func set(subject: String) {
        _subjectLabel.text = subject
    }
    
    func set(subjectTextHeight: CGFloat) {
        _subjectLabelHeight.constant = subjectTextHeight
    }
    
    func set(details: String) {
        _detailsLabel.text = details
    }
    
    func updateOrderDetailsLabelHeight(details: String) {
        let detailsHeight = details.heightForView(font: DesignSystem.Typography.defaultFont.font, width: UIScreen.main.bounds.size.width - 48)
        _detailsLabelheight.constant = detailsHeight
    }
    
    func set(priority: String) {
        _priorityLabel.text = priority
    }
    
    func set(department: String) {
        _departmentLabel.text = department
    }
    
    func set(departmentHeight: CGFloat) {
        _departmentLabelHeight.constant = departmentHeight
    }
}
