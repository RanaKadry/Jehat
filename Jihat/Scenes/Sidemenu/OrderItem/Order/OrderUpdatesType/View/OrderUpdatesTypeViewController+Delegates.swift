//
//  OrderUpdatesTypeViewController+Delegates.swift
//  Jihat
//
//  Created Peter Bassem on 30/09/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

extension OrderUpdatesTypeViewController: OrderUpdatesTypeViewProtocol {
    
    func refreshScrollView() {
        view.layoutIfNeeded()
    }
    
    func refreshCollectionView() {
        _collectionView.reloadData()
    }
    
    func changeButtonImage(atIndex index: Int, play: Bool) {
        if let cell = _collectionView.cellForItem(at: IndexPath(item: index, section: 0)) as? VoiceNoteCollectionViewCell {
            changeButtonImage(cell._playPauseButton, play: play)
        }
    }
    
    func scrollToBottom() {
        _collectionView.scrollToBottom()
    }
}
