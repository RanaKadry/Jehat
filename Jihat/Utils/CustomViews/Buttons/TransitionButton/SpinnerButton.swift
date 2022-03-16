//
//  SpinnerButton.swift
//  MandoBee
//
//  Created by Peter Bassem on 29/08/2021.
//

import UIKit

@IBDesignable
class SpinnerButton: TransitionButton {
    
    // MARK: - IBInspectable
    @IBInspectable
     var spinColor: UIColor = DesignSystem.Colors.text1Color.color {
        didSet { configure() }
    }
    
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
        spinnerColor = spinColor
    }
}
