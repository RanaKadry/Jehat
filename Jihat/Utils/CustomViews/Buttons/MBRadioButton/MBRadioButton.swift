//
//  MBRadioButton.swift
//  MandoBee
//
//  Created by Peter Bassem on 27/07/2021.
//

import UIKit
import MBRadioCheckboxButton

class MBRadioButton: RadioButton {
    
    // MARK: - IBInspectable
    @IBInspectable var title: String = ""
    
    // MARK: - Variables
    private let color = DesignSystem.Colors.primaryActionColor.color

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
        style = .circle
        radioButtonColor = RadioButtonColor(active: color, inactive: color)
        setTitleColor(DesignSystem.Colors.primaryActionColor.color, for: .normal)
        if LocalizationHelper.isArabic() {
            transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
            titleLabel?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
            imageView?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        }
    }
    
    // MARK: - Public Configuration
    func setAttributedTitle(forTitle title: String, description: String) {
        titleLabel?.numberOfLines = 0
        let attributedTitle = NSMutableAttributedString(string: title.localized(), attributes: [.foregroundColor: DesignSystem.Colors.primaryActionText.color, .font: DesignSystem.Typography.buttonSmall.font])
        attributedTitle.append(NSAttributedString(string: " \(description.localized())", attributes: [.foregroundColor: DesignSystem.Colors.textPlaceholder.color, .font: DesignSystem.Typography.description.font]))
        setAttributedTitle(attributedTitle, for: .normal)
    }
    
}
