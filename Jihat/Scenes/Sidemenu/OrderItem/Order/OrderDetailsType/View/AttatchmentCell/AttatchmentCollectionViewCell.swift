//
//  AttatchmentCollectionViewCell.swift
//  Jihat
//
//  Created by Peter Bassem on 04/10/2021.
//

import UIKit

protocol AttatchmentCollectionViewCellProtocol {
    func setImage(_ image: String)
    func setImage(image: UIImage?)
}

final class AttatchmentCollectionViewCell: BaseCollectionViewCell {
    
    // MARK: - Outlets
    @IBOutlet private weak var attatchmentFileImageView: UIImageView!

    // MARK: - Variables
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

// MARK: - AttatchmentCollectionViewCellProtocol
extension AttatchmentCollectionViewCell: AttatchmentCollectionViewCellProtocol {
    
    func setImage(_ image: String) {
        KingfisherHelpers.downloadImage(attatchmentFileImageView, withImageUrlString: image, imageType: .person)
    }
    
    func setImage(image: UIImage?) {
        attatchmentFileImageView.image = image
    }
}
