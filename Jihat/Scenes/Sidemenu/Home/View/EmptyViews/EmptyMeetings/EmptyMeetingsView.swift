//
//  EmptyMeetingsView.swift
//  Jihat
//
//  Created by Peter Bassem on 20/11/2021.
//  Copyright © 2021 Jehat. All rights reserved.
//

import UIKit

class EmptyMeetingsView: BaseView {

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
        Bundle.main.loadNibNamed("EmptyMeetingsView", owner: self, options: nil)
        addSubview(containerView)
        containerView.frame = bounds
        containerView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
}
