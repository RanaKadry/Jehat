//
//  ImageDownloaderImageView.swift
//  MandoBee
//
//  Created by Peter Bassem on 08/09/2021.
//

import UIKit

final class ImageDownloaderImageView: UIImageView {

    func downloadImage(fromUrl url: URL, placeholder: UIImage? = DesignSystem.Icon.defaultUserImage.image) {
        kf.indicatorType = .activity
        kf.setImage(with: url, placeholder: placeholder, options: [
            .transition(.fade(1)),
            .cacheOriginalImage
        ]) { result in
            switch result {
            case .success(let value):
                print("Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
    }
}
