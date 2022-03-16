//
//  FilterMeetingPresenter.swift
//  Jihat
//
//  Created by Peter Bassem on 28/11/2021.
//  Copyright © 2021 Jehat. All rights reserved.
//
//

import Foundation

// MARK: FilterMeeting Presenter -

class FilterMeetingPresenter: BasePresenter {

    weak var view: FilterMeetingViewProtocol?
    private let interactor: FilterMeetingInteractorInputProtocol
    private let router: FilterMeetingRouterProtocol
    private let meetingFilterItems: [MeetingFilterItemsResponse]
    private let filterMeetingCompletion: FilterMeetingCompletion
    
    private var selectedMeetingFilterItem: MeetingFilterItemsResponse!
    
    init(view: FilterMeetingViewProtocol, interactor: FilterMeetingInteractorInputProtocol, router: FilterMeetingRouterProtocol, meetingFilterItems: [MeetingFilterItemsResponse], filterMeetingCompletion: FilterMeetingCompletion) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.meetingFilterItems = meetingFilterItems
        self.filterMeetingCompletion = filterMeetingCompletion
    }
}

// MARK: - FilterMeetingPresenterProtocol
extension FilterMeetingPresenter: FilterMeetingPresenterProtocol {
    
    func viewDidLoad() {
        view?.refreshTableView()
    }
    
    func perfromValidateSelectionItem() {
        selectedMeetingFilterItem == nil ? view?.disableFilterButton() : view?.enableFilterButton()
    }
}

// MARK: - FilterOrderItemsTableView Setup
extension FilterMeetingPresenter {
    
    var filterItemsCount: Int {
        return meetingFilterItems.count
    }
    
    func configureFilterItemCell(_ cell: FilterItemTableViewCellProtocol, atIndex index: Int) {
        cell.set(filterTitle: String(format: "%@ %@", "•", meetingFilterItems[index].name ?? ""))
        meetingFilterItems[index].selected ? cell.showCheckMark() : cell.removeCheckMark()
    }
    
    func didSelectFilterItem(atIndex index: Int) {
        selectedMeetingFilterItem = meetingFilterItems[index]
        meetingFilterItems.forEach { $0.selected = false }
        meetingFilterItems[index].selected = true
        view?.refreshTableView()
    }
}

// MARK: - API
extension FilterMeetingPresenter: FilterMeetingInteractorOutputProtocol {
    
}

// MARK: - Selectors
extension FilterMeetingPresenter {
    
    func performContainerViewDidPressed() {
        router.dismissViewController()
    }
    
    func performFilterButtonPressed() {
        filterMeetingCompletion?(selectedMeetingFilterItem)
        router.dismissViewController()
    }
    
    func cancelButtonPressed() {
        router.dismissViewController()
    }
}
