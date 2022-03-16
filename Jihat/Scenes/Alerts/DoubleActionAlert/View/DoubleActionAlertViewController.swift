//
//  DoubleActionAlertViewController.swift
//  Jihat
//
//  Created by Peter Bassem on 23/10/2021.
//

import UIKit

final class DoubleActionAlertViewController: BaseViewController {
    
    // MARK: - Outlets
    @IBOutlet private weak var alertImageView: UIImageView!
    @IBOutlet private weak var alertTitleLabel: UILabel!
    @IBOutlet private weak var alertMessageLabel: UILabel!
    @IBOutlet private weak var alertPrimaryActionButton: UIButton! {
        didSet { alertPrimaryActionButton.layer.maskedCorners = LocalizationHelper.isArabic() ? [.layerMaxXMaxYCorner] : [.layerMinXMaxYCorner] }
    }
    @IBOutlet private weak var alertSecondaryActionButton: UIButton! {
        didSet { alertSecondaryActionButton.layer.maskedCorners = LocalizationHelper.isArabic() ? [.layerMinXMaxYCorner] : [.layerMaxXMaxYCorner] }
    }
    
    // MARK: - Variables
    var presenter: DoubleActionAlertPresenterProtocol!
    
    var _alertImageView: UIImageView {
        return alertImageView
    }
    var _alertTitleLabel: UILabel {
        return alertTitleLabel
    }
    var _alertMessageLabel: UILabel {
        return alertMessageLabel
    }
    var _alertPrimaryActionButton: UIButton {
        return alertPrimaryActionButton
    }
    var _alertSecondaryActionButton: UIButton {
        return alertSecondaryActionButton
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        presenter.viewDidLoad()
    }
}

// MARK: - Helpers
extension DoubleActionAlertViewController {
    
}

// MARK: - Selectors
extension DoubleActionAlertViewController {
    
    @IBAction
    private func primaryActionButtonDidPressed(_ sender: UIButton) {
        presenter.primaryActionButtonPressed()
    }
    
    @IBAction
    private func secondaryActionButtonDidPressed(_ sender: UIButton) {
        presenter.secondaryActionButtonPressed()
    }
}
