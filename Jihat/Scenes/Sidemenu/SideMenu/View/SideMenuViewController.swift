//
//  SideMenuViewController.swift
//  Jihat
//
//  Created by Peter Bassem on 23/09/2021.
//

import UIKit

final class SideMenuViewController: BaseViewController {
    
    // MARK: - Outlets
    @IBOutlet private weak var collectionView: UICollectionView!
    
    // MARK: - Variables
    var presenter: SideMenuPresenterProtocol!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        presenter.viewDidLoad()
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        SideMenuNavigationViewController.removeLeftMenuNavigationController()
        SideMenuNavigationViewController.removeRightMenuNavigationController()
    }
}

// MARK: - Helpers
extension SideMenuViewController {
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.registerHeader(header: SidemenuHeaderCollectionViewCell.self, type: .header)
        collectionView.registerCell(cell: SidemenuItemCollectionViewCell.self)
        collectionView.alwaysBounceVertical = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.bounces = false
        collectionView.contentInsetAdjustmentBehavior = .never
    }
}


// MARK: - Selectors
extension SideMenuViewController {
    
}

// MARK: - UICollectionViewDataSource
extension SideMenuViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueHeader(for: kind, at: indexPath) as SidemenuHeaderCollectionViewCell
        presenter.configureSidemenuHeader(header)
        header.changeLanguage = { [weak self] in
            self?.presenter.performChangeLanguage()
        }
        header.editProfile = { [weak self] in
            self?.presenter.performShowProfile()
        }
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.sidemenuItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(at: indexPath) as SidemenuItemCollectionViewCell
        presenter.configureSidemenuItemCell(cell, atIndex: indexPath.item)
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension SideMenuViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Relay to delegate about menu item selection.
        presenter.didSelectMenuItem(atIndex: indexPath.item)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension SideMenuViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: collectionView.frame.size.width, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: collectionView.frame.size.width, height: 50)
    }
}
