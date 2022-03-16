//
//  AsteriskLabel.swift
//  Jihat
//
//  Created by Peter Bassem on 18/09/2021.
//

import UIKit

final class AsteriskLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    // MARK: - Private Configuration
    private func configure() {
        text = "*"
        textColor = DesignSystem.Colors.text4Color.color
        font = DesignSystem.Typography.asterisk.font
    }
}
