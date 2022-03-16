//
//  AttachmentsCollectionViewController.swift
//  Jihat
//
//  Created by Peter Bassem on 09/10/2021.
//

import UIKit

final class AttachmentsCollectionViewController: BaseCollectionViewController {
    
    // MARK: - Variables
    var presenter: AttachmentsPresenterProtocol!
    private var collectionViewDataSourceDelegate: CollectionView<AttatchmentCollectionViewCell>!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

// MARK: - Helpers
extension AttachmentsCollectionViewController {
    
    func setupCollectionView() {
        let totalSpacing: CGFloat = (2 * sectionInsets.left) + ((numberOfItemsPerRow - 1) * spacingBetweenCells)
        let width = ((UIScreen.main.bounds.width - 64) - totalSpacing) / numberOfItemsPerRow
        collectionViewDataSourceDelegate = CollectionView(itemsCount: presenter.attatchmentsCount, itemConfigurator: { [weak self] cell, index in
            self?.presenter.configureAttatchemtCell(cell, atIndex: index)
        }, itemSelector: { [weak self] index in
            self?.presenter.didSelectAttachment(atIndex: index)
        }, itemSize: .init(width: width, height: width), itemSpacing: spacingBetweenCells)
        collectionView.registerCell(cell: AttatchmentCollectionViewCell.self)
        collectionView.dataSource = collectionViewDataSourceDelegate
        collectionView.delegate = collectionViewDataSourceDelegate
        collectionView.backgroundColor = .clear
    }
}
