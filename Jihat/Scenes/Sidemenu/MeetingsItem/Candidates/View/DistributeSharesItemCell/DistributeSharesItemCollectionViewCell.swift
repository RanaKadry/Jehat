//
//  DistributeSharesItemCollectionViewCell.swift
//  Jihat
//
//  Created by Ahmed Barghash on 14/11/2021.
//  Copyright © 2021 Jehat. All rights reserved.
//

import UIKit

protocol DistributeSharesItemCollectionViewCellDelegate: AnyObject {
    func didUpdateShareValue(_ cell: DistributeSharesCollectionViewCellProtocol, atIndex index: Int, parentIndex: Int?, shareValue: String)
    func didEndUpdateShareValue(_ cell: DistributeSharesCollectionViewCellProtocol, atIndex index: Int, parentIndex: Int?, shareValue: String)
}

protocol DistributeSharesCollectionViewCellProtocol {
    func set(candidateName: String)
    
    var index: Int! { get set }
    var parentIndex: Int? { get set }
    var delegate: DistributeSharesItemCollectionViewCellDelegate? { get set }
}

final class DistributeSharesItemCollectionViewCell: BaseCollectionViewCell {

    // MARK: - Outlets
    @IBOutlet weak var candidateNameLabel: UILabel!
    @IBOutlet weak var sharesNumberTextField: UITextField! {
        didSet {
            sharesNumberTextField.addTarget(self, action: #selector(textFieldDidChangeText(_:)), for: .editingChanged)
            sharesNumberTextField.delegate = self
        }
    }
    
    // MARK: - Variables
    var index: Int!
    var parentIndex: Int?
    weak var delegate: DistributeSharesItemCollectionViewCellDelegate?
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
// MARK: - Helpers

// MARK: - Selectors
extension DistributeSharesItemCollectionViewCell {
    
    @objc
    private func textFieldDidChangeText(_ sender: UITextField) {
        guard let index = index else { fatalError("MUST SELECT INDEX FIRST!") }
        delegate?.didUpdateShareValue(self, atIndex: index, parentIndex: parentIndex, shareValue: sharesNumberTextField.text ?? "")
    }
}

// MARK: - DistributeSharesItemCollectionViewCellProtocol
extension DistributeSharesItemCollectionViewCell: DistributeSharesCollectionViewCellProtocol {
    
    func set(candidateName: String) {
        candidateNameLabel.text = candidateName
    }
}

// MARK: - UITextFieldDelegate
extension DistributeSharesItemCollectionViewCell: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let index = index else { fatalError("MUST SELECT INDEX FIRST!") }
        delegate?.didEndUpdateShareValue(self, atIndex: index, parentIndex: parentIndex, shareValue: sharesNumberTextField.text ?? "")
    }
}
