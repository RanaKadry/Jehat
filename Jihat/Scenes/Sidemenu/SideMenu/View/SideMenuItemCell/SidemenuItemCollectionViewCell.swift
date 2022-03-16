//
//  SidemenuItemCollectionViewCell.swift
//  Jihat
//
//  Created by Peter Bassem on 23/09/2021.
//

import UIKit

protocol SidemenuItemCollectionViewCellProtocol {
    func displayItem(imageName: String)
    func displayItem(title: String)
}

final class SidemenuItemCollectionViewCell: BaseCollectionViewCell {

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

// MARK: - Helpers

// MARK: - SidemenuItemCollectionViewCellProtocol
extension SidemenuItemCollectionViewCell: SidemenuItemCollectionViewCellProtocol {
    
    func displayItem(imageName: String) {
        itemImageView.image = UIImage(named: imageName)
    }
    
    func displayItem(title: String) {
        itemTitleLabel.text = title
    }
}
