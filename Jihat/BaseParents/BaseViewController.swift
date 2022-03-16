//
//  BaseViewController.swift
//  Aman Elshark
//
//  Created by Peter Bassem on 1/12/20.
//  Copyright © 2020 Peter Bassem. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController, NVActivityIndicatorViewable {
    
    // MARK: - Properties
    
    
    // MARK: - Init
    init() {
        super.init(nibName: String(describing: type(of: self)), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - UIViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func validateInputs(textFields: [UITextField], errorMessages: [String]) -> (Bool, String?) {
        for (index, textField) in textFields.enumerated() {
            if !textField.hasText || textField.text?.count ?? 0 <= 0 {
                return (false, errorMessages[index])
            }
        }
        return (true, nil)
    }
    
    func validateEmptyTextFields(textFields tfs: [UITextField]) -> [UITextField] {
        var emptyTextFields = [UITextField]()
        tfs.forEach { (textField) in
            if !textField.hasText || textField.text?.count ?? 0 < 0 {
                emptyTextFields.append(textField)
            }
        }
        return emptyTextFields
    }
    
    // MARK: - Actions
}

extension BaseViewController: BaseViewProtocol {
    
    func showLoading() {
        view.subviews.forEach { $0.alpha = 0 }
        startAnimating(.init(width: 60, height: 60), type: .ballSpinFadeLoader, color: DesignSystem.Colors.text3Color.color, backgroundColor: DesignSystem.Colors.backgroundTransparentColor.color, fadeInAnimation: nil)
    }

    func hideLoading() {
        view.subviews.forEach { $0.alpha = 1 }
        stopAnimating()
    }
    
    func showErrorAlert(error: String) {
        AlertView.AlertViewBuilder().setTitle(with: LocalizationSystem.sharedInstance.localizedStringForKey(key: "error", comment: ""))
            .setMessage(with: error)
            .setAlertType(with: .failure)
            .setButtonTitle(with: LocalizationSystem.sharedInstance.localizedStringForKey(key: "done", comment: ""))
            .build()
        return
    }
    
    func showErrorMessage(message: String) {
        ToastManager.shared.showError(message: message, view: view, completion: nil)
    }
    
    func showBottomMessage(_ message: String) {
        TTGSnackbarHelper.showSnackBar(inView: self.view, wihthLocationInView: .bottom, withMessage: message) { (_) in }
    }
}
