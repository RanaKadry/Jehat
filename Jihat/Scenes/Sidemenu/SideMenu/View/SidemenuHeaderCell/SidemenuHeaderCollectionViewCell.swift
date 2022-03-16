//
//  SidemenuHeaderCollectionViewCell.swift
//  Jihat
//
//  Created by Peter Bassem on 23/09/2021.
//

import UIKit

protocol SidemenuHeaderCollectionViewCellProtocol {
    func displayDesiredLanguage(language: String)
    func display(username: String)
    func hideEditProfileButton()
    func showEditProfileButton()
}

final class SidemenuHeaderCollectionViewCell: BaseCollectionViewCell {
    
    // MARK: - Outlets
    @IBOutlet private weak var changeLanguageButton: UIButton! {
        didSet { changeLanguageButton.imageToRightIfNotArabic() }
    }
    @IBOutlet private weak var usernameLabel: UILabel!
    @IBOutlet private weak var editProfileButton: UIButton! {
        didSet { editProfileButton.setupButtonWithImage() }
    }
    
    // MARK: - Variables
    
    var changeLanguage: (() -> Void)?
    var editProfile: (() -> Void)?

    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

// MARK: - Helpers
extension SidemenuHeaderCollectionViewCell {
    
}

// MARK: - Selector
extension SidemenuHeaderCollectionViewCell {
    
    @IBAction
    private func changeLanguageButtonDidPressed(_ sender: UIButton) {
        changeLanguage?()
    }
    
    @IBAction
    private func editProfileButtonDidPressed(_ sender: UIButton) {
        editProfile?()
    }
}

// MARK: - SidemenuHeaderCollectionViewCellProtocol
extension SidemenuHeaderCollectionViewCell: SidemenuHeaderCollectionViewCellProtocol {
    
    func displayDesiredLanguage(language: String) {
        changeLanguageButton.setTitle(language, for: .normal)
    }
    
    func display(username: String) {
        usernameLabel.text = username
    }
    
    func hideEditProfileButton() {
        editProfileButton.isHidden = true
    }
    
    func showEditProfileButton() {
        editProfileButton.isHidden = false
    }
}
