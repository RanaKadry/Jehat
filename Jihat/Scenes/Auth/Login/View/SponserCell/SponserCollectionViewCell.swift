//
//  SponserCollectionViewCell.swift
//  Jihat
//
//  Created by Peter Bassem on 16/10/2021.
//

import UIKit

protocol SponserCollectionViewCellProtocol {
    func set(sponser: String)
}

final class SponserCollectionViewCell: BaseCollectionViewCell {
    
    // MARK: - Outlets
    @IBOutlet private weak var sponserImageView: UIImageView!
    
    // MARK: - Variables

    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

// MARK: - SponserCollectionViewCellProtocol
extension SponserCollectionViewCell: SponserCollectionViewCellProtocol {
    
    func set(sponser: String) {
        KingfisherHelpers.downloadImage(sponserImageView, withImageUrlString: sponser, imageType: .person)
    }
}
