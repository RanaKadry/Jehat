//
//  MBRadioButtonContainer.swift
//  MandoBee
//
//  Created by Peter Bassem on 27/07/2021.
//

import UIKit
import MBRadioCheckboxButton

protocol MBRadioButtonContainerDelegate: AnyObject {
    func mBRadioButtonContainerDidSelect(_ button: MBRadioButton, isSelected selected: Bool)
}

class MBRadioButtonContainer: RadioButtonContainer {

    // MARK: - Variables
    weak var rdbDelegate: MBRadioButtonContainerDelegate?
    
    // MARK: - Init
    init() {
        super.init()
        configure()
    }
    
    // MARK: - Private Configuration
    private func configure() {
        delegate = self
    }
}

extension MBRadioButtonContainer: RadioButtonDelegate {
    
    func radioButtonDidSelect(_ button: RadioButton) {
        if let radioButton = button as? MBRadioButton {
            rdbDelegate?.mBRadioButtonContainerDidSelect(radioButton, isSelected: true)
        }
    }
    
    func radioButtonDidDeselect(_ button: RadioButton) {
//        if let radioButton = button as? MBRadioButton {
////            rdbDelegate?.mBRadioButtonContainerDidSelect(radioButton, isSelected: false)
//        }
    }
}
