////
////  ImagePickerMultiSelectManager.swift
////  Jihat
////
////  Created by Peter Bassem on 04/11/2021.
////  Copyright © 2021 Jehat. All rights reserved.
////
//
import Foundation
import UIKit

class ImagePickerMultiSelectManager: NSObject {
    
    private static var picker: YPImagePicker!
    private static var viewController: UIViewController?
    private static var pickImagesCallBack: ((_ images: [UIImage], _ urls: [URL?]) -> Void)?
    
    override init() {
        super.init()
    }
    
    static func pickImages(_ viewController: UIViewController?, imagesLimit: Int = 0, _ callback: @escaping (_ images: [UIImage], _ urls: [URL?]) -> Void) {
        pickImagesCallBack = callback
        self.viewController = viewController
        
        var config = YPImagePickerConfiguration()
        config.isScrollToChangeModesEnabled = true
        config.onlySquareImagesFromCamera = false
        config.usesFrontCamera = false
        config.showsPhotoFilters = false
        config.shouldSaveNewPicturesToAlbum = true
        config.albumName = "DefaultYPImagePickerAlbumName"
        config.startOnScreen = YPPickerScreen.photo
        config.screens = [.photo, .library]
        config.showsCrop = .none
        config.targetImageSize = YPImageSize.original
        config.overlayView = UIView()
        config.hidesStatusBar = true
        config.hidesBottomBar = false
        config.hidesCancelButton = false
        config.startOnScreen = .photo
        config.preferredStatusBarStyle = UIStatusBarStyle.default
        
        config.library.mediaType = .photo
        config.library.defaultMultipleSelection = true
        config.library.minNumberOfItems = 0
        config.library.maxNumberOfItems = imagesLimit
        
        picker = YPImagePicker(configuration: config)
        
        picker.didFinishPicking { items, cancelled in
            if cancelled {
                viewController?.dismiss(animated: true)
            } else {
                var images: [UIImage] = []
                var urls: [URL?] = []
                items.forEach {
                    switch $0 {
                    case .photo(let photo):
                        images.append(photo.image)
                        photo.asset?.getURL { responseURL in
                            urls.append(responseURL)
                        }
                    default: break
                    }
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    pickImagesCallBack?(images, urls)
                    viewController?.dismiss(animated: true)
                }
            }
        }
        
        viewController?.present(picker, animated: true)
    }
}
