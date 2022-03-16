//
//  MultiDistributeSharesItemCollectionViewCell.swift
//  Jihat
//
//  Created by Peter Bassem on 15/12/2021.
//  Copyright © 2021 Jehat. All rights reserved.
//

import UIKit

protocol MultiDistributeSharesItemCollectionViewCellProtocol {
    func set(candidatesNumberOrSharesNumber: String)
    func setupDisributeCandidatesSharesCollectionView(itemsCount: Int, rowConfigurator: @escaping ((_ cell: DistributeSharesCollectionViewCellProtocol, _ index: Int) -> Void), itemSize: @escaping ((_ index: Int) -> CGSize))
}

final class MultiDistributeSharesItemCollectionViewCell: BaseCollectionViewCell {
    
    // MARK: - Outlets
    @IBOutlet private weak var candidatesOrSharesNumberLabel: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    // MARK: - Variables
    private var distrubuteCandidateSharescollectionViewDataSetUp: CollectionViewDynamicCellSize<DistributeSharesItemCollectionViewCell>!
    weak var collectionViewReference: UIViewController!
    var collectionViewHeightCompletion: ((CGFloat) -> Void)?

    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

// MARK: - Helpers
extension MultiDistributeSharesItemCollectionViewCell {
    
    private func updateCollectionViewHeight() {
        collectionView.reloadData()
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.collectionViewHeightCompletion?(self.collectionView.collectionViewLayout.collectionViewContentSize.height)
            UIView.animate(withDuration: 0.3) {
                self.layoutIfNeeded()
            }
        }
    }
}

// MARK: - MultiDistributeSharesItemCollectionViewCellProtocol
extension MultiDistributeSharesItemCollectionViewCell: MultiDistributeSharesItemCollectionViewCellProtocol {
    
    func set(candidatesNumberOrSharesNumber: String) {
        candidatesOrSharesNumberLabel.text = candidatesNumberOrSharesNumber
    }
    
    func setupDisributeCandidatesSharesCollectionView(itemsCount: Int, rowConfigurator: @escaping ((_ cell: DistributeSharesCollectionViewCellProtocol, _ index: Int) -> Void), itemSize: @escaping ((_ index: Int) -> CGSize)) {
        distrubuteCandidateSharescollectionViewDataSetUp = CollectionViewDynamicCellSize(itemsCount: itemsCount, itemConfigurator: rowConfigurator, itemSelector: {  _ in }, itemSize: itemSize, itemSpacing: 8)
        
        collectionView.registerCell(cell: DistributeSharesItemCollectionViewCell.self)
        collectionView.dataSource = distrubuteCandidateSharescollectionViewDataSetUp
        collectionView.delegate = distrubuteCandidateSharescollectionViewDataSetUp
        updateCollectionViewHeight()
    }
}
