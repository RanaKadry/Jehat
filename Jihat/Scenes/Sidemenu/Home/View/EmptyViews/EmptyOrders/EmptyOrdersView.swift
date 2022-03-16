//
//  EmptyOrdersView.swift
//  Jihat
//
//  Created by Peter Bassem on 29/10/2021.
//  Copyright © 2021 Jehat. All rights reserved.
//

import UIKit

final class EmptyOrdersView: BaseView {

    // MARK: - Outlets
    @IBOutlet var containerView: UIView!
    
    // MARK: - Variables
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        commontInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commontInit()
    }
    
    // MARK: - Private Configure
    private func commontInit() {
        Bundle.main.loadNibNamed("EmptyOrdersView", owner: self, options: nil)
        addSubview(containerView)
        containerView.frame = bounds
        containerView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
}
