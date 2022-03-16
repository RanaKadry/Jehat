//
//  VoiceNoteCollectionViewCell.swift
//  Jihat
//
//  Created by Peter Bassem on 08/10/2021.
//

import UIKit

protocol VoiceNoteCollectionViewCellProtocol {
    func display(messageOwner: String)
    func display(messageDate: String)
    func display(messageText: String)
}

class VoiceNoteCollectionViewCell: BaseCollectionViewCell {
    
    // MARK: - Outlets
    @IBOutlet private weak var textMessageOwnerLabel: UILabel!
    @IBOutlet private weak var textMessageSendDateLabel: UILabel!
    @IBOutlet private weak var textMessageLabel: UILabel!
    @IBOutlet private weak var playPauseButton: UIButton!
    
    // MARK: - Variables
    var _playPauseButton: UIButton {
        return playPauseButton
    }
    
    var textMessageLabelWidth: CGFloat {
        return textMessageLabel.frame.size.width
    }

    // MARK: - Variables
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}

// MARK: - Selectors
extension VoiceNoteCollectionViewCell {
}

// MARK: - VoiceNoteCollectionViewCellProtocol
extension VoiceNoteCollectionViewCell: VoiceNoteCollectionViewCellProtocol {
    
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
