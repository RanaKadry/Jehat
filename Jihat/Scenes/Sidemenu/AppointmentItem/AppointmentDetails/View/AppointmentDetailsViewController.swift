//
//  AppointmentDetailsViewController.swift
//  Jihat
//
//  Created by Ahmed Barghash on 28/10/2021.
//

import UIKit

class AppointmentDetailsViewController: BaseViewController {

    // MARK: - Outlets
    @IBOutlet private weak var appNavigationBar: AppNavigationBar!
    @IBOutlet private weak var appointmentTitleLabel: UILabel!
    @IBOutlet private weak var appointmentDetailsLabel: UILabel!
    @IBOutlet private weak var attachedDocumentNumberLabel: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var collectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet private weak var appointmentDateLabel: UILabel!
    @IBOutlet private weak var appointmentTimeLabel: UILabel!
    @IBOutlet private weak var alertTypeLabel: UILabel!
    
    // MARK: - Variables
    var presenter: AppointmentDetailsPresenterProtocol!
    
    var _appointmentTitleLabel: UILabel{
        return appointmentTitleLabel
    }
    var _appointmentDetailsLabel: UILabel{
        return appointmentDetailsLabel
    }
    var _attachedDocumentNumberLabel: UILabel {
        return attachedDocumentNumberLabel
    }
    var _collectionView: UICollectionView {
        return collectionView
    }
    private var collectionViewDataSourceDelegate: CollectionView<AttatchmentCollectionViewCell>!
    var _appointmentDateLabel: UILabel{
        return appointmentDateLabel
    }
    var _appointmentTimeLabel: UILabel{
        return appointmentTimeLabel
    }
    var _alertTypeLabel: UILabel{
        return alertTypeLabel
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
        setupAppNavigationBar()
        
    }
    
}

// MARK: - Helpers
extension AppointmentDetailsViewController {
    
    private func setupAppNavigationBar() {
        appNavigationBar.backButtonPressed = { [weak self] in
            self?.presenter.performBack()
        }
    }
    
    func setupCollectionView() {
        let totalSpacing: CGFloat = (2 * sectionInsets.left) + ((numberOfItemsPerRow - 1) * spacingBetweenCells)
        let width = ((UIScreen.main.bounds.width - 28) - totalSpacing) / numberOfItemsPerRow
        collectionViewDataSourceDelegate = CollectionView(itemsCount: presenter.attatchmentsCount, itemConfigurator: { [weak self] cell, index in
            self?.presenter.configureAttatchemtCell(cell, atIndex: index)
        }, itemSelector: { [weak self] index in
            self?.presenter.didSelectAttachemt(atIndex: index)
        }, itemSize: .init(width: width, height: width), itemSpacing: spacingBetweenCells)
        collectionView.registerCell(cell: AttatchmentCollectionViewCell.self)
        collectionView.dataSource = collectionViewDataSourceDelegate
        collectionView.delegate = collectionViewDataSourceDelegate
        collectionView.backgroundColor = .clear
        updateCollectionViewHeight()
    }
    
    private func updateCollectionViewHeight() {
        collectionView.reloadData()
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.collectionViewHeightConstraint.constant = self.collectionView.collectionViewLayout.collectionViewContentSize.height
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
    }
}

// MARK: - Selectors
extension AppointmentDetailsViewController {
    
}
