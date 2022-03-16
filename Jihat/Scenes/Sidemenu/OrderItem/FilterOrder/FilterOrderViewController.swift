//
//  FilterOrderViewController.swift
//  Jihat
//
//  Created by Peter Bassem on 27/11/2021.
//  Copyright © 2021 Jehat. All rights reserved.
//
//

import UIKit

final class FilterOrderViewController: BaseViewController {

    // MARK: - Outlets
    @IBOutlet weak var blurVisualEffectContainerView: UIView!
    @IBOutlet weak var filterOrderItemsTableView: UITableView!
    @IBOutlet weak var filterOrderItemsTableViewHeight: NSLayoutConstraint!
    @IBOutlet private weak var filterButton: UIButton! {
        didSet { filterButton.layer.maskedCorners = LocalizationHelper.isArabic() ? [.layerMaxXMaxYCorner] : [.layerMinXMaxYCorner] }
    }
    @IBOutlet private weak var cancelButton: UIButton! {
        didSet { cancelButton.layer.maskedCorners = LocalizationHelper.isArabic() ? [.layerMinXMaxYCorner] : [.layerMaxXMaxYCorner] }
    }
    
    // MARK: - Variables
	var presenter: FilterOrderPresenterProtocol!
    
    private lazy var tapGesture: UITapGestureRecognizer = {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(blurVisualEffectViewDidPressed(_:)))
        tapGesture.delegate = self
        return tapGesture
    }()
    
    private var filterOrderItemsTableViewDataSourceDelegate: TableView<FilterItemTableViewCell>!
    
    var _filterButton: UIButton {
        return filterButton
    }

    // MARK: - Lifecycle
	override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        presenter.viewDidLoad()
        blurVisualEffectContainerView.addGestureRecognizer(tapGesture)
        presenter.perfromValidateSelectionItem()
    }
}

// MARK: - Helpers
extension FilterOrderViewController {
    
    func setupOrderFilterItemsTableView() {
        filterOrderItemsTableViewDataSourceDelegate = TableView(itemsCount: presenter.filterItemsCount, rowConfigurator: { [weak self] cell, row in
            self?.presenter.configureFilterItemCell(cell, atIndex: row)
        }, rowSelector: { [weak self] row in
            self?.presenter.didSelectFilterItem(atIndex: row)
            self?.presenter.perfromValidateSelectionItem()
        }, rowHeight: 35)
        filterOrderItemsTableView.dataSource = filterOrderItemsTableViewDataSourceDelegate
        filterOrderItemsTableView.delegate =  filterOrderItemsTableViewDataSourceDelegate
        filterOrderItemsTableView.registerCell(cell: FilterItemTableViewCell.self)
        filterOrderItemsTableView.separatorStyle = .none
        updateTableViewHeight()
    }
    
    private func updateTableViewHeight() {
        filterOrderItemsTableView.reloadData()
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.filterOrderItemsTableViewHeight.constant = min(210, self.filterOrderItemsTableView.contentSize.height)
            self.view.layoutIfNeeded()
        }
    }
}

// MARK: - Selectors
extension FilterOrderViewController {
    
    @objc
    private func blurVisualEffectViewDidPressed(_ sender: UITapGestureRecognizer) {
        presenter.performContainerViewDidPressed()
    }
    
    @IBAction
    private func filterButtonDidPressed(_ sender: UIButton) {
        presenter.performFilterButtonPressed()
    }
    
    @IBAction
    private func cancelButtonDidPressed(_ sender: UIButton) {
        presenter.cancelButtonPressed()
    }
}

// MARK: - UIGestureRecognizerDelegate
extension FilterOrderViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
         return touch.view == gestureRecognizer.view
    }
}
