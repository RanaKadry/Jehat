//
//  DocumentsItemCollectionViewCell.swift
//  Jihat
//
//  Created by Ahmed Barghash on 04/10/2021.
//

import UIKit

protocol DocumentsCollectionViewCellProtocol {
    func set(documentArabicName: String)
    func set(documentEnglishName: String)
    func set(documentNumber: String)
    func set(endDate: String)
}

protocol DocumentsItemCollectionViewCellDelegate: AnyObject {
    func didEditDocument(atIndex index: Int)
    func didShareDocument(atIndex index: Int)
    func didDeleteDocument(atIndex index: Int)
}

class DocumentsItemCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Outlets
    @IBOutlet private weak var documentArabicNameLabel: UILabel!
    @IBOutlet private weak var documentEnglishNameLabel: UILabel!
    @IBOutlet private weak var documentNumberLabel: UILabel!
    @IBOutlet private weak var endDateLabel: UILabel!

    // MARK: - Variables
    var index: Int!
    weak var delegate: DocumentsItemCollectionViewCellDelegate?
    
    var _documentArabicNameLabel: UILabel {
        return documentArabicNameLabel
    }
    var _documentEnglishNameLabel: UILabel {
        return documentEnglishNameLabel
    }
    var _documentNumberLabel: UILabel {
        return documentNumberLabel
    }
    var _endDateLabel: UILabel {
        return endDateLabel
    }

    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

// MARK: - Helpers
extension DocumentsItemCollectionViewCell {
    
}

// MARK: - Selectors
extension DocumentsItemCollectionViewCell {
    
    @IBAction
    private func editButtonDidPressed(_ sender: UIButton) {
        guard let index = index else { return }
        delegate?.didEditDocument(atIndex: index)
    }
    
    @IBAction
    private func shareButtonDidPressed(_ sender: UIButton) {
        guard let index = index else { return }
        delegate?.didShareDocument(atIndex: index)
    }
    
    @IBAction
    private func deleteButtonDidPressed(_ sender: UIButton) {
        guard let index = index else { return }
        delegate?.didDeleteDocument(atIndex: index)
    }
    
}

// MARK: - MyOrderItemCollectionViewCellProtocol
extension DocumentsItemCollectionViewCell: DocumentsCollectionViewCellProtocol {
    
    func set(documentArabicName: String) {
        documentArabicNameLabel.text = documentArabicName
    }
    
    func set(documentEnglishName: String) {
        documentEnglishNameLabel.text = documentEnglishName
    }
    
    func set(documentNumber: String) {
        documentNumberLabel.text = documentNumber
    }
    
    func set(endDate: String) {
        endDateLabel.text = endDate
    }
    
}
