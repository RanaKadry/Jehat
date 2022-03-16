//
//  TextMessageCollectionViewCell.swift
//  Jihat
//
//  Created by Peter Bassem on 08/10/2021.
//

import UIKit

protocol TextMessageCollectionViewCellProtocol {
    func display(messageOwner: String)
    func display(messageDate: String)
    func display(messageText: String)
}

class TextMessageCollectionViewCell: BaseCollectionViewCell {

    // MARK: - Outlets
    @IBOutlet private weak var textMessageOwnerLabel: UILabel!
    @IBOutlet private weak var textMessageSendDateLabel: UILabel!
    @IBOutlet private weak var textMessageLabel: UILabel!
    
    // MARK: - Variables
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

// MARK: - TextMessageCollectionViewCellProtocol
extension TextMessageCollectionViewCell: TextMessageCollectionViewCellProtocol {
    
    func display(messageOwner: String) {
        textMessageOwnerLabel.text = messageOwner
    }
    
    func display(messageDate: String) {
        textMessageSendDateLabel.text = messageDate
    }
    
    func display(messageText: String) {
        textMessageLabel.text = messageText
    }
}
