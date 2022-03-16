//
//  FilterMeetingProtocols.swift
//  Jihat
//
//  Created by Peter Bassem on 28/11/2021.
//  Copyright © 2021 Jehat. All rights reserved.
//
//

import Foundation

// MARK: FilterMeeting Protocols

protocol FilterMeetingViewProtocol: BaseViewProtocol {
    var presenter: FilterMeetingPresenterProtocol! { get set }
    
    func refreshTableView()
    func enableFilterButton()
    func disableFilterButton()
}

protocol FilterMeetingPresenterProtocol: BasePresenterProtocol {
    var view: FilterMeetingViewProtocol? { get set }
    
    func viewDidLoad()
    func perfromValidateSelectionItem()
    
    var filterItemsCount: Int { get }
    func configureFilterItemCell(_ cell: FilterItemTableViewCellProtocol, atIndex index: Int)
    func didSelectFilterItem(atIndex index: Int)

    func performContainerViewDidPressed()
    func performFilterButtonPressed()
    func cancelButtonPressed()
}

protocol FilterMeetingRouterProtocol: BaseRouterProtocol {
    
}

protocol FilterMeetingInteractorInputProtocol: BaseInteractorInputProtocol {
    var presenter: FilterMeetingInteractorOutputProtocol? { get set }
    
}

protocol FilterMeetingInteractorOutputProtocol: BaseInteractorOutputProtocol {
    
}
