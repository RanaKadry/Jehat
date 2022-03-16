//
//  MyOrderItemCollectionViewCell.swift
//  Jihat
//
//  Created by Peter Bassem on 26/09/2021.
//

import UIKit

protocol MyOrderItemCollectionViewCellDelegate: AnyObject {
    func showDetailsButtonPressed(atIndex index: Int)
}

protocol MyOrderItemCollectionViewCellProtocol {
    func set(orderNumber: String)
    func set(expectedCompletionDate: String)
    func set(subject: String)
    func set(details: String)
}

final class MyOrderItemCollectionViewCell: BaseCollectionViewCell {
    
    // MARK: - Outlets
    @IBOutlet private weak var upperContainerView: UIView!
    @IBOutlet private weak var orderNumberLabel: UILabel!
    @IBOutlet private weak var expectedCompletionDateLabel: UILabel!
    @IBOutlet private weak var orderSubjectLabel: UILabel!
    @IBOutlet private weak var orderDetailsLabel: UILabel!
    
    // MARK: - Variables
    var index: Int!
    weak var delegate: MyOrderItemCollectionViewCellDelegate?

    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        upperContainerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
}

// MARK: - Helpers
extension MyOrderItemCollectionViewCell {
    
}

// MARK: - Selectors
extension MyOrderItemCollectionViewCell {
    
    @IBAction
    private func showDetailsButtonDidPressed(_ sender: UIButton) {
        guard let index = index else { fatalError("Should Define Index First!!") }
        delegate?.showDetailsButtonPressed(atIndex: index)
    }
}

// MARK: - MyOrderItemCollectionViewCellProtocol
extension MyOrderItemCollectionViewCell: MyOrderItemCollectionViewCellProtocol {
    
    func set(orderNumber: String) {
        orderNumberLabel.text = orderNumber
    }
    
    func set(expectedCompletionDate: String) {
        expectedCompletionDateLabel.text = expectedCompletionDate
    }
    
    func set(subject: String) {
        orderSubjectLabel.text = subject
    }
    
    func set(details: String) {
        orderDetailsLabel.text = details
    }
}
