//
//  FilterMeetingViewController.swift
//  Jihat
//
//  Created by Peter Bassem on 28/11/2021.
//  Copyright © 2021 Jehat. All rights reserved.
//
//

import UIKit

final class FilterMeetingViewController: BaseViewController {

    // MARK: - Outlets
    @IBOutlet private weak var blurVisualEffectContainerView: UIView!
    @IBOutlet private weak var filterMeetingItemsTableView: UITableView!
    @IBOutlet private weak var filterMeetingItemsTableViewHeight: NSLayoutConstraint!
    @IBOutlet private weak var filterButton: UIButton! {
        didSet { filterButton.layer.maskedCorners = LocalizationHelper.isArabic() ? [.layerMaxXMaxYCorner] : [.layerMinXMaxYCorner] }
    }
    @IBOutlet private weak var cancelButton: UIButton! {
        didSet { cancelButton.layer.maskedCorners = LocalizationHelper.isArabic() ? [.layerMinXMaxYCorner] : [.layerMaxXMaxYCorner] }
    }
    
    // MARK: - Variables
	var presenter: FilterMeetingPresenterProtocol!
    
    private lazy var tapGesture: UITapGestureRecognizer = {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(blurVisualEffectViewDidPressed(_:)))
        tapGesture.delegate = self
        return tapGesture
    }()
    
    private var filterMeetingItemsTableViewDataSourceDelegate: TableView<FilterItemTableViewCell>!
    
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
extension FilterMeetingViewController {
    
    func setupMeetingFilterItemsTableView() {
        filterMeetingItemsTableViewDataSourceDelegate = TableView(itemsCount: presenter.filterItemsCount, rowConfigurator: { [weak self] cell, row in
            self?.presenter.configureFilterItemCell(cell, atIndex: row)
        }, rowSelector: { [weak self] row in
            self?.presenter.didSelectFilterItem(atIndex: row)
            self?.presenter.perfromValidateSelectionItem()
        }, rowHeight: 35)
        filterMeetingItemsTableView.dataSource = filterMeetingItemsTableViewDataSourceDelegate
        filterMeetingItemsTableView.delegate =  filterMeetingItemsTableViewDataSourceDelegate
        filterMeetingItemsTableView.registerCell(cell: FilterItemTableViewCell.self)
        filterMeetingItemsTableView.separatorStyle = .none
        updateTableViewHeight()
    }
    
    private func updateTableViewHeight() {
        filterMeetingItemsTableView.reloadData()
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.filterMeetingItemsTableViewHeight.constant = min(210, self.filterMeetingItemsTableView.contentSize.height)
            self.view.layoutIfNeeded()
        }
    }

}

// MARK: - Selectors
extension FilterMeetingViewController {
    
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
extension FilterMeetingViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
         return touch.view == gestureRecognizer.view
    }
}
