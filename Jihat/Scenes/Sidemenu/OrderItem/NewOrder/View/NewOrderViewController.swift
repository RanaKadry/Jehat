//
//  NewOrderViewController.swift
//  Jihat
//
//  Created by Ahmed Barghash on 28/09/2021.
//

import UIKit

final class NewOrderViewController: BaseViewController {

    // MARK: - Outlets
    @IBOutlet private weak var appNavigationBar: AppNavigationBar!
    @IBOutlet private weak var directedEntityTextField: UITextField! {
        didSet {
            directedEntityTextField.delegate = self
            directedEntityTextField.addTarget(self, action: #selector(textFieldValueDidChanged(_:)), for: .editingChanged)
        }
    }
    @IBOutlet private weak var orderTypeTextField: UITextField! {
        didSet {
//            orderTypeTextField.addPickerView(orderTypePickerView)
            orderTypeTextField.delegate = self
            orderTypeTextField.addTarget(self, action: #selector(textFieldValueDidChanged(_:)), for: .editingChanged)
        }
    }
    @IBOutlet private weak var propertiesCollectionView: UICollectionView!
    @IBOutlet private weak var propertiesCollectionViewHeight: NSLayoutConstraint!
    
    @IBOutlet private weak var topicTextFiled: UITextField! {
        didSet {
            topicTextFiled.delegate = self
            topicTextFiled.addTarget(self, action: #selector(textFieldValueDidChanged(_:)), for: .editingChanged)
        }
    }
    @IBOutlet private weak var topicLimitLabel: UILabel!
    @IBOutlet private weak var detailsTextView: UITextView! {
        didSet { detailsTextView.delegate = self }
    }
    @IBOutlet private weak var detailsLimitLabel: UILabel!
    @IBOutlet private weak var attachedDocumentsTextField: UITextField! {
        didSet {
            attachedDocumentsTextField.delegate = self
            attachedDocumentsTextField.addTarget(self, action: #selector(textFieldValueDidChanged(_:)), for: .editingChanged)
        }
    }
    @IBOutlet private weak var pickedImageTextField: UITextField! {
        didSet {
            pickedImageTextField.delegate = self
            pickedImageTextField.addTarget(self, action: #selector(textFieldValueDidChanged(_:)), for: .editingChanged)
        }
    }
    @IBOutlet private weak var orderPriorityTextField: UITextField! {
        didSet {
            orderPriorityTextField.addPickerView(orderPriorityPickerView)
            orderPriorityTextField.addTarget(self, action: #selector(textFieldValueDidChanged(_:)), for: .editingChanged)
        }
    }
    @IBOutlet private weak var sendOrderButton: SpinnerButton!
    
    // MARK: - Variables
    
    var presenter: NewOrderPresenterProtocol!
    
    var _directedEntityTextField: UITextField{
        return directedEntityTextField
    }
    private let directedEntityPickerView = UIPickerView()
    private var directEntityPickerDataSourceDelegate: PickerView!
    var _orderTypeTextField: UITextField{
        return orderTypeTextField
    }
    let orderTypePickerView = UIPickerView()
    private var orderTypePickerDataSourceDelegate: PickerView!
    var _propertiesCollectionView: UICollectionView {
        return propertiesCollectionView
    }
    var _propertiesCollectionViewHeight: NSLayoutConstraint {
        return propertiesCollectionViewHeight
    }
    private var propertiesColletionViewDataSourceDelegate: CollectionViewDynamicCellSize<PropertyCollectionViewCell>!
    private var addedPropertyCellHeight: CGFloat = 0.0
    
    var _topicTextFiled: UITextField{
        return topicTextFiled
    }
    var _topicLimitLabel: UILabel {
        return topicLimitLabel
    }
    var _detailsTextView: UITextView {
        return detailsTextView
    }
    var _detailsLimitLabel: UILabel {
        return detailsLimitLabel
    }
    var _attachedDocumentsTextField: UITextField {
        return attachedDocumentsTextField
    }
    var _pickedImageTextField: UITextField {
        return pickedImageTextField
    }
    var _orderPriorityTextField: UITextField {
        return orderPriorityTextField
    }
    private var orderPriorityPickerView = UIPickerView()
    private var orderPriorityPickerDataSourceDelegate: PickerView!
    var _sendOrderButton: SpinnerButton!{
        return sendOrderButton
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
        setupAppNavigationBar()
        topicLimitLabel.text = "\(20.localized() ?? "") \("letter".localized())"
        detailsLimitLabel.text = "\(520.localized() ?? "") \("letter".localized())"
        presenter.performObserveInputs(entity: directedEntityTextField.text, orderType: orderTypeTextField.text, topic: topicTextFiled.text, details: detailsTextView.text, attachedDocuments: attachedDocumentsTextField.text, images: pickedImageTextField.text, orderPriority: orderTypeTextField.text)
        
        
    }
}

// MARK: - Helpers
extension NewOrderViewController {
    
    private func setupAppNavigationBar() {
        appNavigationBar.backButtonPressed = { [weak self] in
            self?.presenter.performBack()
        }
    }
    
    func setupEntitiesPickerView() {
        directEntityPickerDataSourceDelegate = PickerView(itemsCount: presenter.entitiesCount, rawConfigurator: { [weak self] (row) -> String in
            self?.presenter.configureEntitiesRow(atIndex: row) ?? ""
        }, itemSelection: { [weak self] (row) in
            self?.presenter.didSelectEntity(atIndex: row)
            self?.presenter.performObserveInputs(entity: self?.directedEntityTextField.text, orderType: self?.orderTypeTextField.text, topic: self?.topicTextFiled.text, details: self?.detailsTextView.text, attachedDocuments: self?.attachedDocumentsTextField.text, images: self?.pickedImageTextField.text, orderPriority: self?.orderTypeTextField.text)
        })
        directedEntityPickerView.dataSource = directEntityPickerDataSourceDelegate
        directedEntityPickerView.delegate = directEntityPickerDataSourceDelegate
    }
    
    func setupOrderTypePickerView() {
        orderTypePickerDataSourceDelegate = PickerView(itemsCount: presenter.orderTypesCount, rawConfigurator: { [weak self] (row) -> String in
            self?.presenter.configureOrderTypesRow(atIndex: row) ?? ""
        }, itemSelection: { [weak self] (row) in
            self?.presenter.didSelectOrderType(atIndex: row)
            self?.presenter.performObserveInputs(entity: self?.directedEntityTextField.text, orderType: self?.orderTypeTextField.text, topic: self?.topicTextFiled.text, details: self?.detailsTextView.text, attachedDocuments: self?.attachedDocumentsTextField.text, images: self?.pickedImageTextField.text, orderPriority: self?.orderTypeTextField.text)
        })
        orderTypePickerView.dataSource = orderTypePickerDataSourceDelegate
        orderTypePickerView.delegate = orderTypePickerDataSourceDelegate
    }
    
    func setupPropertiesCollectionView() {
        propertiesColletionViewDataSourceDelegate = CollectionViewDynamicCellSize(itemsCount: presenter.propertiesCount, itemConfigurator: { [weak self] cell, row in
            cell.index = row
            cell.delegate = self
            self?.presenter.configurePropertyCell(cell, atIndex: row)
        }, itemSelector: { _ in }, itemSize: { [unowned self] index in
            return .init(width: self.propertiesCollectionView.frame.size.width, height: 91)
        }, itemSpacing: 19)
        propertiesCollectionView.dataSource = propertiesColletionViewDataSourceDelegate
        propertiesCollectionView.delegate = propertiesColletionViewDataSourceDelegate
        propertiesCollectionView.registerCell(cell: PropertyCollectionViewCell.self)
        updatePropertiesCollectionViewHeight()
    }
    
    private func updatePropertiesCollectionViewHeight() {
        propertiesCollectionView.reloadData()
        DispatchQueue.main.async { [unowned self] in
            self.propertiesCollectionViewHeight.constant = self.propertiesCollectionView.collectionViewLayout.collectionViewContentSize.height
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    func setupOrderPriotityPickerView() {
        orderPriorityPickerDataSourceDelegate = PickerView(itemsCount: presenter.orderPriorityCount, rawConfigurator: { [weak self] (row) -> String in
            self?.presenter.configureOrderPriorityRow(atIndex: row) ?? ""
        }, itemSelection: { [weak self] (row) in
            self?.presenter.didSelectOrderPriority(atIndex: row)
            self?.presenter.performObserveInputs(entity: self?.directedEntityTextField.text, orderType: self?.orderTypeTextField.text, topic: self?.topicTextFiled.text, details: self?.detailsTextView.text, attachedDocuments: self?.attachedDocumentsTextField.text, images: self?.pickedImageTextField.text, orderPriority: self?.orderTypeTextField.text)
        })
        orderPriorityPickerView.dataSource = orderPriorityPickerDataSourceDelegate
        orderPriorityPickerView.delegate = orderPriorityPickerDataSourceDelegate
    }
}

// MARK: - Selectors
extension NewOrderViewController {
    
    @objc
    private func textFieldValueDidChanged(_ sender: UITextField) {
        presenter.performObserveInputs(entity: directedEntityTextField.text, orderType: orderTypeTextField.text, topic: topicTextFiled.text, details: detailsTextView.text, attachedDocuments: attachedDocumentsTextField.text, images: pickedImageTextField.text, orderPriority: orderTypeTextField.text)
    }
    
    @IBAction
    private func attachDocumentButtonDidPressed(_ sender: UIButton) {
        presenter.performAttachDocuments()
    }
    
    @IBAction
    private func pickUpImageButtonDidPressed(_ sender: UIButton) {
        presenter.performAttachImagesButtonPressed()
    }
    
    @IBAction
    private func sendOrderButtonDidPressed(_ sender: SpinnerButton) {
        presenter.performSendOrder(topic: topicTextFiled.text, orderDetails: detailsTextView.text)
    }
    
    @IBAction
    private func saveAsDraftButtonDidPressed(_ sender: SpinnerButton) {
        presenter.performSaveAsDraft()
    }
}

// MARK: - UITextFieldDelegate
extension NewOrderViewController: UITextFieldDelegate {
        
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let currentText = topicTextFiled.text ?? ""
        guard let stringRange = Range(range, in: currentText) else {
            return false
        }
        let updateText = currentText.replacingCharacters(in: stringRange, with: string)
        topicLimitLabel.text = "\((20 - updateText.count).localized() ?? "") \("letter".localized())"
        
        return updateText.count < 20
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == directedEntityTextField {
            presenter.performDirectedEntityTextFieldPressed()
            return false
        } else if textField == orderTypeTextField {
            presenter.performOrderTypeTextFieldPressed()
            return false
        }
        return true
    }
}

// MARK: - UITextViewDelegate
extension NewOrderViewController: UITextViewDelegate {
    
    func textViewDidEndEditing(_ textView: UITextView) {
        presenter.performObserveInputs(entity: directedEntityTextField.text, orderType: orderTypeTextField.text, topic: topicTextFiled.text, details: detailsTextView.text, attachedDocuments: attachedDocumentsTextField.text, images: pickedImageTextField.text, orderPriority: orderTypeTextField.text)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = textView.text ?? ""
        guard let stringRange = Range(range, in: currentText) else {
            return false
        }
        let updateText = currentText.replacingCharacters(in: stringRange, with: text)
        detailsLimitLabel.text = "\((520 - updateText.count).localized() ?? "") \("letter".localized())"
        return updateText.count < 520
    }
}

// MARK: - PropertyCollectionViewCellDelegate
extension NewOrderViewController: PropertyCollectionViewCellDelegate {
    
    func propertyTextInput(inputString: String, atIndex index: Int) {
        presenter.performPropertyTextInput(inputString: inputString, atIndex: index)
    }
    
    func propertyDateInput(_ cell: PropertyCollectionViewCellProtocol, date: Date, atIndex index: Int) {
        presenter.performPropertyDateInput(cell, date: date, atIndex: index)
    }
    
    func showMultiSelectionOptions(atIndex index: Int, height: CGFloat) {
        self.addedPropertyCellHeight = height
        propertiesCollectionView.reloadItems(at: [IndexPath(item: index, section: 0)])
    }
}
