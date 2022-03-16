//
//  MeetingTermsCollectionViewController.swift
//  Jihat
//
//  Created by Peter Bassem on 08/12/2021.
//  Copyright © 2021 Jehat. All rights reserved.
//

import UIKit

final class MeetingTermsCollectionViewController: BaseCollectionViewController {
    
    // MARK: - Variables
    var presenter: MeetingTermsPresenterProtocol!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        presenter.viewDidLoad(meetingTerms: nil)
        setupCollectionView()
    }
}

// MARK: - Helpers
extension MeetingTermsCollectionViewController {
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.registerCell(cell: MeetingTermCollectionViewCell.self)
    }
}

// MARK: - UICollectionViewDataSource
extension MeetingTermsCollectionViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.meetingsCount
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(at: indexPath) as MeetingTermCollectionViewCell
        cell.index = indexPath.item
        cell.delegate = self
        presenter.configureMeetingTermCell(cell, atIndex: indexPath.item)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MeetingTermsCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let termTextHeight = presenter.termText(atIndex: indexPath.item).heightForView(font: DesignSystem.Typography.action.font, width: UIScreen.main.bounds.size.width - 48)
        let height: CGFloat = 16 + 1 + 60 + 1 + 24 + termTextHeight + 24 + 40
        return .init(width: UIScreen.main.bounds.size.width, height: height)
    }
}

// MARK: - MeetingTermCollectionViewCellDelegate
extension MeetingTermsCollectionViewController: MeetingTermCollectionViewCellDelegate {
    
    func voteButtonPresed(atIndex index: Int) {
        presenter.performVoteButtonPressed(atIndex: index)
    }
}
