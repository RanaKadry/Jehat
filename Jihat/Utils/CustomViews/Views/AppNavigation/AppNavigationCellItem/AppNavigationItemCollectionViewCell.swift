//
//  AppNavigationItemCollectionViewCell.swift
//  Jihat
//
//  Created by Peter Bassem on 18/09/2021.
//

import UIKit

protocol AppNavigationItemCollectionViewCellProtocol {
    func displayItem(title: String)
}

final class AppNavigationItemCollectionViewCell: BaseCollectionViewCell {
    
    // MARK: - Outlets
    @IBOutlet private weak var itemTitleLabel: UILabel!
    
    // MARK: - Variables
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

// MARK: - AppNavigationItemCollectionViewCellProtocol
extension AppNavigationItemCollectionViewCell: AppNavigationItemCollectionViewCellProtocol {
    
    func displayItem(title: String) {
        itemTitleLabel.text = title
    }
}
