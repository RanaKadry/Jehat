//
//  FilterOrderPresenter.swift
//  Jihat
//
//  Created by Peter Bassem on 27/11/2021.
//  Copyright © 2021 Jehat. All rights reserved.
//
//

import Foundation

// MARK: FilterOrder Presenter -

class FilterOrderPresenter: BasePresenter {

    weak var view: FilterOrderViewProtocol?
    private let interactor: FilterOrderInteractorInputProtocol
    private let router: FilterOrderRouterProtocol
    private let orderFilterItems: [TicketFilterItemsResponse]
    private let filterOrderCompletion: FilterOrderCompletion
    
    private var selectedOrderFilterItem: TicketFilterItemsResponse!
    
    init(view: FilterOrderViewProtocol, interactor: FilterOrderInteractorInputProtocol, router: FilterOrderRouterProtocol, orderFilterItems: [TicketFilterItemsResponse], filterOrderCompletion: FilterOrderCompletion) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.orderFilterItems = orderFilterItems
        self.filterOrderCompletion = filterOrderCompletion
    }
}

// MARK: - FilterOrderPresenterProtocol
extension FilterOrderPresenter: FilterOrderPresenterProtocol {
    
    func viewDidLoad() {
        view?.refreshTableView()
    }
    
    func perfromValidateSelectionItem() {
        selectedOrderFilterItem == nil ? view?.disableFilterButton() : view?.enableFilterButton()
    }
}

// MARK: - FilterOrderItemsTableView Setup
extension FilterOrderPresenter {
    
    var filterItemsCount: Int {
        return orderFilterItems.count
    }
    
    func configureFilterItemCell(_ cell: FilterItemTableViewCellProtocol, atIndex index: Int) {
        cell.set(filterTitle: String(format: "%@ %@", "•", orderFilterItems[index].name ?? ""))
        orderFilterItems[index].selected ? cell.showCheckMark() : cell.removeCheckMark()
    }
    
    func didSelectFilterItem(atIndex index: Int) {
        selectedOrderFilterItem = orderFilterItems[index]
        orderFilterItems.forEach { $0.selected = false }
        orderFilterItems[index].selected = true
        view?.refreshTableView()
    }
}

// MARK: - API
extension FilterOrderPresenter: FilterOrderInteractorOutputProtocol {
    
}

// MARK: - Selectors
extension FilterOrderPresenter {
    
    func performContainerViewDidPressed() {
        router.dismissViewController()
    }
    
    func performFilterButtonPressed() {
        filterOrderCompletion?(selectedOrderFilterItem)
        router.dismissViewController()
    }
    
    func cancelButtonPressed() {
        router.dismissViewController()
    }
}
