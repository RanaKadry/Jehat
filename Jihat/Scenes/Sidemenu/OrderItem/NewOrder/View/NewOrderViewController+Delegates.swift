//
//  NewOrderViewController+Delegates.swift
//  Jihat
//
//  Created Ahmed Barghash on 28/09/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

extension NewOrderViewController: NewOrderViewProtocol {
    
    func refreshEntitiesPicker() {
        setupEntitiesPickerView()
    }
    
    func setSelectedEntity(_ entity: String?) {
        _directedEntityTextField.text = entity
    }
        
    func disableOrderTypeTextField() {
        _orderTypeTextField.isEnabled = false
    }
    
    func enableOrderTypeTextField() {
        _orderTypeTextField.isEnabled = true
    }
    
    func clearsOrderTypeTextField() {
        _orderTypeTextField.text = ""
    }
    
    func resetOrderTypePicker() {
        orderTypePickerView.selectRow(0, inComponent: 0, animated: false)
    }
        
    func refreshOrderTypesPicker() {
        setupOrderTypePickerView()
    }
    
    func setSelectedOrderType(_ orderType: String?) {
        _orderTypeTextField.text = orderType
    }
    
    func refreshPropertiesCollectionView() {
        setupPropertiesCollectionView()
    }
    
    func setAttachedDocumentsCount(documentsCount: String) {
        _attachedDocumentsTextField.text = documentsCount
    }
    
    func setPickedImagesNumber(imagesNumber: String) {
        _pickedImageTextField.text = imagesNumber
    }
        
    func refreshOrderPriorityPicker() {
        setupOrderPriotityPickerView()
    }
    
    func setSelectedOrderPriority(_ orderPriority: String?) {
        _orderPriorityTextField.text = orderPriority
    }
    
    func enableSendOrderButton() {
        _sendOrderButton.configureButton(true)
    }
    
    func disableSendOrderButton() {
        _sendOrderButton.configureButton(false)
    }
    
    func startLoadingOnSendOrderButton() {
        _sendOrderButton.startAnimation()
    }
    
    func stopLoadingOnSendOrderButton() {
        _sendOrderButton.stopAnimation()
    }
}
