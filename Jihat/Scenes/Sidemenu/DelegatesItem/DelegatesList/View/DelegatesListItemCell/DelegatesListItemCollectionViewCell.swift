//
//  DelegatesListItemCollectionViewCell.swift
//  Jihat
//
//  Created by Ahmed Barghash on 02/10/2021.
//

import UIKit

protocol DelegatesListCollectionViewCellProtocol {
    func set(delegateArabicName: String)
    func set(delegateEnglishName: String)
    func set(delegatePhone: String)
    func set(delegateEmail: String)
}

protocol DelegatesListItemCollectionViewCellDelegate: AnyObject {
    func didEditDelegate(atIndex index: Int)
    func didShareDelegate(atIndex index: Int)
    func didDeleteDelegate(atIndex index: Int)
}

class DelegatesListItemCollectionViewCell: UICollectionViewCell {

    // MARK: - Outlets
    @IBOutlet private weak var arabicNameLabel: UILabel!
    @IBOutlet private weak var englishNameLabel: UILabel!
    @IBOutlet private weak var phoneButton: UnderlineTextButton!
    @IBOutlet private weak var emailButton: UnderlineTextButton!
    
    // MARK: - Variables
    var index: Int!
    weak var delegate: DelegatesListItemCollectionViewCellDelegate?

    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
}

// MARK: - Helpers
extension DelegatesListItemCollectionViewCell {
    
}

// MARK: - Selectors
extension DelegatesListItemCollectionViewCell {
    
    @IBAction
    private func phoneButtonDidPressed(_ sender: Any) {
    }
    @IBAction
    private func emailButtonDidPressed(_ sender: Any) {
    }
    
    @IBAction
    private func editButtonDidPressed(_ sender: UIButton) {
        guard let index = index else { return }
        delegate?.didEditDelegate(atIndex: index)
    }
    
    @IBAction
    private func shareButtonDidPressed(_ sender: UIButton) {
        guard let index = index else { return }
        delegate?.didShareDelegate(atIndex: index)
    }
    
    @IBAction
    private func deleteButtonDidPressed(_ sender: UIButton) {
        guard let index = index else { return }
        delegate?.didDeleteDelegate(atIndex: index)
    }
    
}

// MARK: - MyOrderItemCollectionViewCellProtocol
extension DelegatesListItemCollectionViewCell: DelegatesListCollectionViewCellProtocol {
    
    func set(delegateArabicName: String) {
        arabicNameLabel.text = delegateArabicName
    }
    
    func set(delegateEnglishName: String) {
        englishNameLabel.text = delegateEnglishName
    }
    
    func set(delegatePhone: String) {
        phoneButton.setTitle(delegatePhone, for: .normal)
    }
    
    func set(delegateEmail: String) {
        emailButton.setTitle(delegateEmail, for: .normal)
    }
    
}
