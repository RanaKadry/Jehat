//
//  TitleWithImageButton.swift
//  Jihat
//
//  Created by Peter Bassem on 28/09/2021.
//
import UIKit

@IBDesignable
class TitleWithImageButton: UIButton {
    
    // MARK: - Variables
    @IBInspectable
    var centerTitleWithImage: Bool = false {
        didSet { configure() }
    }
    @IBInspectable
    var titleInset: Int = 0 {
        didSet { configureTitleEdgeInsets() }
    }
    @IBInspectable
    var imageInset: Int = 0 {
        didSet { configureImageEdgeInsets() }
    }
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        configureTitleEdgeInsets()
        configureImageEdgeInsets()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
        configureTitleEdgeInsets()
        configureImageEdgeInsets()
    }
    
    // MARK: - Private Configuration
    private func configure() {
        if centerTitleWithImage {
            contentHorizontalAlignment = .center
             configureTitleEdgeInsets()
            configureImageEdgeInsets()
        } else {
            contentHorizontalAlignment = LocalizationHelper.isArabic() ? .right : .left
        }
    }
    
    private func configureTitleEdgeInsets() {
        titleEdgeInsets = LocalizationHelper.isArabic() ? .init(top: 0, left: 0, bottom: 0, right: titleInset.toCGFloat()) : .init(top: 0, left: titleInset.toCGFloat(), bottom: 0, right: 0)
    }
    
    private func configureImageEdgeInsets() {
        imageEdgeInsets = LocalizationHelper.isArabic() ? .init(top: 0, left: 0, bottom: 0, right: imageInset.toCGFloat()) : .init(top: 0, left: imageInset.toCGFloat(), bottom: 0, right: 0)
    }
}
