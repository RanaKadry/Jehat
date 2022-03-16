//
//  FilterAppointmentViewController.swift
//  Jihat
//
//  Created by Peter Bassem on 20/11/2021.
//  Copyright © 2021 Jehat. All rights reserved.
//
//

import UIKit

final class FilterAppointmentViewController: BaseViewController {

    // MARK: - Outlets
    @IBOutlet weak var blurVisualEffectContainerView: UIView!
    @IBOutlet weak var filterStartDateTextField: UITextField! {
        didSet {
            filterStartDateTextField.setDateInputViewDatePicker(target: self, selector: #selector(startDatePickerViewValueDidChanged(_:)))
        }
    }
    @IBOutlet weak var filterEndDateTextField: UITextField! {
        didSet {
            filterEndDateTextField.inputView = endDatePickerView
        }
    }
    @IBOutlet private weak var filterButton: UIButton! {
        didSet { filterButton.layer.maskedCorners = LocalizationHelper.isArabic() ? [.layerMaxXMaxYCorner] : [.layerMinXMaxYCorner] }
    }
    @IBOutlet private weak var cancelButton: UIButton! {
        didSet { cancelButton.layer.maskedCorners = LocalizationHelper.isArabic() ? [.layerMinXMaxYCorner] : [.layerMaxXMaxYCorner] }
    }
    
    // MARK: - Variables
	var presenter: FilterAppointmentPresenterProtocol!

    private lazy var tapGesture: UITapGestureRecognizer = {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(blurVisualEffectViewDidPressed(_:)))
        tapGesture.delegate = self
        return tapGesture
    }()
    
    var _filterStartDateTextField: UITextField {
        return filterStartDateTextField
    }
    var _filterEndDateTextField: UITextField {
        return filterEndDateTextField
    }
    var endDatePickerView = UIDatePicker()
    var _filterButton: UIButton {
        return filterButton
    }
    
    // MARK: - Lifecycle
	override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        presenter.viewDidLoad()
        blurVisualEffectContainerView.addGestureRecognizer(tapGesture)
        setupEndDatePickerView()
        presenter.performValidateInputs(startDate: filterStartDateTextField.text, endDate: filterEndDateTextField.text)
    }
}

// MARK: - Helpers
extension FilterAppointmentViewController {
    
    private func setupEndDatePickerView() {
        endDatePickerView.datePickerMode = .date
        if #available(iOS 13.4, *) {
            endDatePickerView.preferredDatePickerStyle = .wheels
        }
        endDatePickerView.addTarget(target, action: #selector(endDatePickerViewValueDidChanged(_:)), for: .valueChanged)
    }
}

// MARK: - Selectors
extension FilterAppointmentViewController {
    
    @objc
    private func blurVisualEffectViewDidPressed(_ sender: UITapGestureRecognizer) {
        presenter.performContainerViewDidPressed()
    }
    
    @objc
    private func startDatePickerViewValueDidChanged(_ sender: UIDatePicker) {
        presenter.performSelectStartDate(date: sender.date)
    }
    
    @objc
    private func endDatePickerViewValueDidChanged(_ sender: UIDatePicker) {
        presenter.performSelectEndDate(date: sender.date)
    }
    
    @IBAction
    private func filterButtonDidPressed(_ sender: UIButton) {
        presenter.filterButtonPressed(startDate: filterStartDateTextField.text, endDate: filterEndDateTextField.text)
    }
    
    @IBAction
    private func cancelButtonDidPressed(_ sender: UIButton) {
        presenter.cancelButtonPressed()
    }
}

// MARK: - UIGestureRecognizerDelegate
extension FilterAppointmentViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
         return touch.view == gestureRecognizer.view
    }
}
