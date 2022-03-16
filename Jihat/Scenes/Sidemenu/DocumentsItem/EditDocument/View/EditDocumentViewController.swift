//
//  EditDocumentViewController.swift
//  Jihat
//
//  Created by Ahmed Barghash on 13/10/2021.
//

import UIKit

final class EditDocumentViewController: BaseViewController {
    
    // MARK: - Outlets
    @IBOutlet private weak var appNavigationBar: AppNavigationBar!
    @IBOutlet private weak var documentArabicNameTextField: UITextField! {
        didSet { documentArabicNameTextField.addTarget(self, action: #selector(textFieldValueDidChanged(_:)), for: .editingChanged) }
    }
    @IBOutlet private weak var documentEnglishNameTextField: UITextField! {
        didSet { documentEnglishNameTextField.addTarget(self, action: #selector(textFieldValueDidChanged(_:)), for: .editingChanged) }
    }
    @IBOutlet private weak var documentNumberTextField: UITextField! {
        didSet { documentNumberTextField.addTarget(self, action: #selector(textFieldValueDidChanged(_:)), for: .editingChanged) }
    }
    @IBOutlet private weak var documentEndDateTextField: UITextField!{
        didSet {
            documentEndDateTextField.setDateInputViewDatePicker(target: self, selector: #selector(documentEndDateTextFieldDateDidChanged(_:)))
            documentEndDateTextField.addTarget(self, action: #selector(textFieldValueDidChanged(_:)), for: .editingChanged)
        }
    }
    @IBOutlet private weak var attachedDocumentNumberLabel: UILabel!
    @IBOutlet weak var addDocumentsButton: UIButton!
    @IBOutlet weak var addImagesButton: UIButton!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var collectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet private weak var saveButton: SpinnerButton!
    @IBOutlet private weak var discardButton: UIButton!
    
    // MARK: - Variables
    var presenter: EditDocumentPresenterProtocol!
    
    var _documentArabicNameTextField: UITextField {
        return documentArabicNameTextField
    }
    var _documentEnglishNameTextField: UITextField {
        return documentEnglishNameTextField
    }
    var _documentNumberTextField: UITextField {
        return documentNumberTextField
    }
    var _documentEndDateTextField: UITextField {
        return documentEndDateTextField
    }
    var _attachedDocumentNumberLabel: UILabel {
        return attachedDocumentNumberLabel
    }
    var _addDocumentsButton: UIButton {
        return addDocumentsButton
    }
    var _addImagesButton: UIButton {
        return addImagesButton
    }
    var _collectionView: UICollectionView {
        return collectionView
    }
    private var collectionViewDataSourceDelegate: CollectionView<AttatchmentCollectionViewCell>!
    var _saveButton: SpinnerButton {
        return saveButton
    }
    var _discardButton: UIButton {
        return discardButton
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        presenter.viewDidLoad()
        presenter.validateInputs(arabicName: documentArabicNameTextField.text, englishName: documentEnglishNameTextField.text, documentNumber: documentNumberTextField.text, endDate: documentEndDateTextField.text)
        setupAppNavigationBar()
    }
}

// MARK: - Helpers
extension EditDocumentViewController {
    
    private func setupAppNavigationBar() {
        appNavigationBar.backButtonPressed = { [weak self] in
            self?.presenter.performDiscardChanges()
        }
    }
    
    func setupCollectionView() {
        let totalSpacing: CGFloat = (2 * sectionInsets.left) + ((numberOfItemsPerRow - 1) * spacingBetweenCells)
        let width = ((UIScreen.main.bounds.width - 28) - totalSpacing) / numberOfItemsPerRow
        collectionViewDataSourceDelegate = CollectionView(itemsCount: presenter.attatchmentsCount, itemConfigurator: { [weak self] cell, index in
            self?.presenter.configureAttatchemtCell(cell, atIndex: index)
        }, itemSelector: { [weak self] index in
            self?.presenter.didSelectAttachemt(atIndex: index)
        }, itemSize: .init(width: width, height: width), itemSpacing: spacingBetweenCells)
        collectionView.registerCell(cell: AttatchmentCollectionViewCell.self)
        collectionView.dataSource = collectionViewDataSourceDelegate
        collectionView.delegate = collectionViewDataSourceDelegate
        collectionView.backgroundColor = .clear
        updateCollectionViewHeight()
    }
    
    private func updateCollectionViewHeight() {
        collectionView.reloadData()
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.collectionViewHeightConstraint.constant = self.collectionView.collectionViewLayout.collectionViewContentSize.height
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
    }
}

// MARK: - Selectors
extension EditDocumentViewController {
    
    @IBAction
    private func editDocumentArabicNameButtonDidPressed(_ sender: UIButton) {
        presenter.performEditDocumentArabicName()
    }
    
    @IBAction
    private func editDocumentEnglishNameButtonDidPressed(_ sender: UIButton) {
        presenter.performEditDocumentEnglishName()
    }
    
    @IBAction
    private func editDocumentNumberButtonDidPressed(_ sender: UIButton) {
        presenter.performEditDocumentNumber()
    }
    
    @IBAction
    private func editEndDateButtonDidPressed(_ sender: UIButton) {
        presenter.performEditEndDate()
    }
    
    @IBAction
    private func addImagesButtonDidPressed(_ sender: UIButton) {
        presenter.performAttachImagesButtonPressed()
    }
    
    @IBAction
    private func addAttachmentsButtonDidPressed(_ sender: UIButton) {
        presenter.performAttachDocumentsButtonPressed()
    }
    
    @IBAction
    private func editAttachmentsButtonDidPressed(_ sender: UIButton) {
        presenter.performEditAttachments()
    }
    
    @objc
    func popUpActionCell(_ longPressGesture : UILongPressGestureRecognizer) {
        // Delete selected Cell
        let point = longPressGesture.location(in: self.collectionView)
        let selectedIndexPath = self.collectionView?.indexPathForItem(at: point)
        guard let indexPath = selectedIndexPath else { return }
        presenter.performDeleteAttachment(atIndex: indexPath.item)
    }
    
    @objc
    private func textFieldValueDidChanged(_ sender: UITextField) {
        presenter.validateInputs(arabicName: documentArabicNameTextField.text, englishName: documentEnglishNameTextField.text, documentNumber: documentNumberTextField.text, endDate: documentEndDateTextField.text)
    }
    
    @IBAction
    private func saveButtonDidPressed(_ sender: SpinnerButton) {
        view.endEditing(true)
        presenter.performSaveChanges(arabicName: documentArabicNameTextField.text, englishName: documentEnglishNameTextField.text, number: documentNumberTextField.text, endDate: documentEndDateTextField.text)
    }
    
    @IBAction
    private func discardButtonDidPressed(_ sender: UIButton) {
        presenter.performDiscardChanges()
    }
    
    @objc
    private func documentEndDateTextFieldDateDidChanged(_ sender: UIDatePicker) {
        presenter.performChangeEndtDate(sender.date)
    }
}
