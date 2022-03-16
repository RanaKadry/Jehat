//
//  TapGestureRecognizer.swift
//  Jihat
//
//  Created by Peter Bassem on 13/10/2021.
//

import UIKit

class TapGestureRecognizer: UITapGestureRecognizer {

    convenience init() {
        self.init()
        delegate = self
    }
}

// MARK: - UIGestureRecognizerDelegate
extension TapGestureRecognizer: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        print(123123)
        return touch.view == view
    }
}
