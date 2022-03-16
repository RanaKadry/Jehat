//
//  MBCheckBoxButton.swift
//  MandoBee
//
//  Created by Peter Bassem on 27/07/2021.
//

import UIKit
import MBRadioCheckboxButton

protocol MBCheckBoxButtonDelegate: AnyObject {
    func mBCheckBoxButtonIsSelected(_ mBCheckBoxButton: MBCheckBoxButton, isSelected selected: Bool)
}

class MBCheckBoxButton: CheckboxButton {
    
    // MARK: - Variables
    private(set) var isCheckBoxSelected: Bool = false
    weak var ckbDelegate: MBCheckBoxButtonDelegate?
    private let color = DesignSystem.Colors.text3Color.color
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure() 
    }
    
    // MARK: - Private Configuration
    private func configure() {
        style = .rounded(radius: 4)
        checkBoxColor = CheckBoxColor(activeColor: color, inactiveColor: color, inactiveBorderColor: color, checkMarkColor: DesignSystem.Colors.primaryActionColor.color)
        delegate = self
    }
}

// MARK: - MBCheckBoxButtonDelegate
extension MBCheckBoxButton: CheckboxButtonDelegate {
    func chechboxButtonDidSelect(_ button: CheckboxButton) {
        isCheckBoxSelected = true
        ckbDelegate?.mBCheckBoxButtonIsSelected(self, isSelected: true)
    }
    
    func chechboxButtonDidDeselect(_ button: CheckboxButton) {
        isCheckBoxSelected = false
        ckbDelegate?.mBCheckBoxButtonIsSelected(self, isSelected: false)
    }
}
