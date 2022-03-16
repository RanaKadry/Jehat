//
//  BlurView.swift
//  Jihat
//
//  Created by Peter Bassem on 24/09/2021.
//

import UIKit

class BlurView: BaseView {

    private lazy var blurEffect: UIBlurEffect = {
        let blurEffect = UIBlurEffect(style: .dark)
        return blurEffect
    }()
    
    private lazy var blurEffectView: UIVisualEffectView = {
       let blurEffetView = UIVisualEffectView(effect: blurEffect)
        blurEffetView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return blurEffetView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    private func configure() {
        addSubview(blurEffectView)
        blurEffectView.fillSuperview()
    }
}
