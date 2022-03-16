//
//  MeetingTermsViewController+Delegates.swift
//  Jihat
//
//  Created by Peter Bassem on 08/12/2021.
//  Copyright © 2021 Jehat. All rights reserved.
//
//

import UIKit

extension MeetingTermsCollectionViewController: MeetingTermsViewProtocol {
    
    func refreshCollectionView() {
        collectionView.reloadData()
    }
}
