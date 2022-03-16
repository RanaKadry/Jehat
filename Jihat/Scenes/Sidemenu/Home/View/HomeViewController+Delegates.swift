//
//  HomeViewController+Delegates.swift
//  Jihat
//
//  Created Peter Bassem on 21/09/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

extension HomeViewController: HomeViewProtocol {
    
    func showBlurView() {
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?._blurView.alpha = 1
        }
    }
    
    func hideBlurView() {
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?._blurView.alpha = 0
        }
    }
    
    func setSearchActionButton(image: UIImage) {
        _searchFilterActionButton.setImage(image, for: .normal)
    }
    
    func updateUserAction(type: UserHomeActions) {
        userSelectionType = type
    }
    
    func refreshCollectionView() {
        updateCollectionViewHeight()
    }
    
    func showEmptyOrders() {
        _collectionView.reloadData() // to remove data when navigating between other sections.
        _collectionView.backgroundView = EmptyOrdersView(frame: _collectionView.bounds)
    }
    
    func showEmptyMeetings() {
        _collectionView.reloadData() // to remove data when navigating between other sections.
        _collectionView.backgroundView = EmptyMeetingsView(frame: _collectionView.bounds)
    }
    
    func showEmptyCalendars() {
        _collectionView.reloadData() // to remove data when navigating between other sections.
        _collectionView.backgroundView = EmptyCalendarView(frame: _collectionView.bounds)
    }
    
    func refreshAppBarCollectionView() {
        setupAppNavigationBarCollectionView()
        _appNavigationBar.itemsCount = presenter.itemsCount
        _appNavigationBar.itemsCountUpdated()
    }
    
    func updateAppBarBottomView(atIndex index: Int) {
        _appNavigationBar.selectedIndex = index
        _appNavigationBar.itemSelected()
    }
    
    func updateAddNewOrderButton(image: UIImage, title: String) {
        _newActionButton.localizationKey = title
        _newActionButton.setImage(image, for: .normal)
    }
    
    func hideNewActionButton() {
        UIView.transition(with: _newActionButton, duration: 0.3, options: .transitionCrossDissolve, animations: { [weak self] in
            self?._newActionButton.isHidden = true
        })
    }
    
    func showNewActionButton() {
        UIView.transition(with: _newActionButton, duration: 0.3, options: .transitionCrossDissolve, animations: { [weak self] in
            self?._newActionButton.isHidden = false
        })
    }
    
    func updateAddNewAppointmentButton(image: UIImage, title: String) {
        _newActionButton.localizationKey = title
        _newActionButton.setImage(image, for: .normal)
    }
    
    func showEmptySearchResults() {
        _collectionView.reloadData()
        _collectionView.backgroundView = EmptySearchResult(frame: _collectionView.bounds)
    }
}
