//
//  PropertyCollectionViewCell.swift
//  Jihat
//
//  Created by Peter Bassem on 29/11/2021.
//  Copyright © 2021 Jehat. All rights reserved.
//

import UIKit

protocol PropertyCollectionViewCellProtocol {
    func set(propertyTitle: String)
    func hideAsteriskLabel()
    func set(propertyTextFieldPlaceholder: String)
    func showDropDownImage()
    func display(text: String)
    func updatekeyboardFrame(frame: CGRect)
    
    func showTextKeyboard()
    func showDatePickerView()
    func showSingleSelectionPickerView(itemsCount: Int, rowCongigurator: @escaping RawConfigurator, itemSelection: @escaping (_ row: Int,_  cellIndex: Int) -> Void)
    func showMultiSelectionDropDown(itemsCount: Int, rowConfigurator: @escaping (_ cell: FilterItemTableViewCellProtocol, _ row: Int) -> Void, rowSelector:  @escaping (_ row: Int, _ cellIndex: Int) -> Void)
    func multiSelectionPropertyOptionsTableView()
}

protocol PropertyCollectionViewCellDelegate: AnyObject {
    func propertyTextInput(inputString: String, atIndex index: Int)
    /// Note: Cell is passed as an arguemnt to display formatted date in textfield from presenter.
    func propertyDateInput(_ cell: PropertyCollectionViewCellProtocol, date: Date, atIndex index: Int)
}

final class PropertyCollectionViewCell: BaseCollectionViewCell {
    
    // MARK: - Outlets
    @IBOutlet private weak var propertyTitleLabel: UILabel!
    @IBOutlet private weak var asteriskLabel: AsteriskLabel!
    @IBOutlet private weak var propertyTextField: DesignableImageTextField! {
        didSet {
            propertyTextField.delegate = self
            propertyTextField.addTarget(self, action: #selector(textFieldValueDidChanged(_:)), for: .editingChanged)
        }
    }
    
    // MARK: - Variables
    var index: Int!
    weak var delegate: PropertyCollectionViewCellDelegate?
    private var showKeyboard: Bool = true
    
    private var pickerViewDataSourceDelegate: PickerView!
    private let pickerView = UIPickerView()
    
    private var multiSelectTableViewDataSourceDelegate: TableView<FilterItemTableViewCell>!
    private lazy var multiSelectTableView: UITableView = {
       let tableView = UITableView()
        tableView.backgroundColor = .clear
        return tableView
    }()
    private var keyboardRectangleFrame: CGRect?
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        propertyTextField.text = nil
        propertyTextField.keyboardType = .default
        propertyTextField.inputView = nil
    }
}

// MARK: - Selectors
extension PropertyCollectionViewCell {
    
    @objc
    private func textFieldValueDidChanged(_ sender: UITextField) {
        guard let index = index else { return }
        delegate?.propertyTextInput(inputString: propertyTextField.text ?? "", atIndex: index)
    }
    
    @objc
    private func datePickerViewValueDidChanged(_ sender: UIDatePicker) {
        guard let index = index else { return }
        delegate?.propertyDateInput(self, date: sender.date, atIndex: index)
    }
}

// MARK: - PropertyCollectionViewCellProtocol
extension PropertyCollectionViewCell: PropertyCollectionViewCellProtocol {
    
    func set(propertyTitle: String) {
        propertyTitleLabel.text = propertyTitle
    }
    
    func hideAsteriskLabel() {
        asteriskLabel.isHidden = true
    }
    
    func set(propertyTextFieldPlaceholder: String) {
        propertyTextField.placeholder = propertyTextFieldPlaceholder
    }
    
    func showDropDownImage() {
        propertyTextField.leadingImage = DesignSystem.Icon.downArrow.image
    }
    
    func display(text: String) {
        propertyTextField.text = text
    }
    
    func updatekeyboardFrame(frame: CGRect) {
        keyboardRectangleFrame = frame
    }
    
    func showTextKeyboard() {
        showKeyboard = true
        propertyTextField.keyboardType = .default
        propertyTextField.autocapitalizationType = .words
    }
    
    func showDatePickerView() {
        showKeyboard = true
        propertyTextField.setDateInputViewDatePicker(target: self, selector: #selector(datePickerViewValueDidChanged(_:)))
    }
    
    func showSingleSelectionPickerView(itemsCount: Int, rowCongigurator: @escaping RawConfigurator, itemSelection: @escaping (_ row: Int, _ cellIndex: Int) -> Void) {
        propertyTextField.addPickerView(pickerView)
        pickerViewDataSourceDelegate = PickerView(itemsCount: itemsCount, rawConfigurator: { row in
            rowCongigurator(row)
        }, itemSelection: { [weak self] row in
            guard let index = self?.index else { return }
            itemSelection(row, index)
        })
        pickerView.dataSource = pickerViewDataSourceDelegate
        pickerView.delegate = pickerViewDataSourceDelegate
        pickerView.showsSelectionIndicator = true
    }
    
    func showMultiSelectionDropDown(itemsCount: Int, rowConfigurator: @escaping (_ cell: FilterItemTableViewCellProtocol, _ row: Int) -> Void, rowSelector:  @escaping (_ row: Int, _ cellIndex: Int) -> Void) {
        showKeyboard = true
        multiSelectTableViewDataSourceDelegate = TableView(itemsCount: itemsCount, rowConfigurator: rowConfigurator, rowSelector: { [weak self] row in
            guard let index = self?.index else { return }
            rowSelector(row, index)
        }, rowHeight: 35)
        multiSelectTableView.dataSource = multiSelectTableViewDataSourceDelegate
        multiSelectTableView.delegate = multiSelectTableViewDataSourceDelegate
        multiSelectTableView.registerCell(cell: FilterItemTableViewCell.self)
        multiSelectTableView.separatorStyle = .none
        multiSelectTableView.allowsMultipleSelection = true
        print("keyboardRectangleFrame:", keyboardRectangleFrame ?? .zero)
        multiSelectTableView.frame = .init(x: 0, y: 0, width: bounds.size.width, height: keyboardRectangleFrame?.size.height ?? 0.0)
        propertyTextField.inputView = multiSelectTableView
    }
    
    func multiSelectionPropertyOptionsTableView() {
        multiSelectTableView.reloadData()
    }
}

// MARK: - UITextFieldDelegate
extension PropertyCollectionViewCell: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return showKeyboard
    }
}
