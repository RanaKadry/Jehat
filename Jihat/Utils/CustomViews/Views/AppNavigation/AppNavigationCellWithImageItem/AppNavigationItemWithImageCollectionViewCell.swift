//
//  AppNavigationItemWithImageCollectionViewCell.swift
//  Jihat
//
//  Created by Peter Bassem on 22/09/2021.
//

import UIKit

protocol AppNavigationItemWithImageCollectionViewCellProtocol {
    func setItem(image: UIImage)
    func setItem(title: String)
}

class AppNavigationItemWithImageCollectionViewCell: BaseCollectionViewCell {
    
    // MARK: - Outlets
    @IBOutlet private weak var itemImageView: UIImageView!
    @IBOutlet private weak var itemTitleLabel: UILabel!
    
    // MARK: - Variables
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

// MARK: - AppNavigationItemWithImageCollectionViewCellProtocol
extension AppNavigationItemWithImageCollectionViewCell: AppNavigationItemWithImageCollectionViewCellProtocol {
    
    func setItem(image: UIImage) {
        itemImageView.image = image
    }
    
    func setItem(title: String) {
        itemTitleLabel.text = title
    }
}
