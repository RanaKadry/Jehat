//
//  SingleActionAlertViewController.swift
//  Jihat
//
//  Created by Peter Bassem on 22/10/2021.
//

import UIKit

final class SingleActionAlertViewController: BaseViewController {
    
    // MARK: - Outlets
    @IBOutlet private weak var alertImageView: UIImageView!
    @IBOutlet private weak var alertTitleLabel: UILabel!
    @IBOutlet private weak var alertMessageLabel: UILabel!
    @IBOutlet private weak var alertActionButton: UIButton! {
        didSet { alertActionButton.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner] }
    }
    
    // MARK: - Variables
    var presenter: SingleActionAlertPresenterProtocol!
    
    var _alertImageView: UIImageView {
        return alertImageView
    }
    var _alertTitleLabel: UILabel {
        return alertTitleLabel
    }
    var _alertMessageLabel: UILabel {
        return alertMessageLabel
    }
    var _alertActionButton: UIButton {
        return alertActionButton
    }
    

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        presenter.viewDidLoad()
    }
}

// MARK: - Selectors
extension SingleActionAlertViewController {
    
    @IBAction
    private func alertActionButtonDidPressed(_ sender: UIButton) {
        presenter.alertActionButtonPressed()
    }
}
