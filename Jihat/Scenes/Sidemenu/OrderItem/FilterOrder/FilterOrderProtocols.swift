//
//  FilterOrderProtocols.swift
//  Jihat
//
//  Created by Peter Bassem on 27/11/2021.
//  Copyright © 2021 Jehat. All rights reserved.
//
//

import Foundation

// MARK: FilterOrder Protocols

protocol FilterOrderViewProtocol: BaseViewProtocol {
    var presenter: FilterOrderPresenterProtocol! { get set }
    
    func refreshTableView()
    func enableFilterButton()
    func disableFilterButton()
}

protocol FilterOrderPresenterProtocol: BasePresenterProtocol {
    var view: FilterOrderViewProtocol? { get set }
    
    func viewDidLoad()
    func perfromValidateSelectionItem()
    
    var filterItemsCount: Int { get }
    func configureFilterItemCell(_ cell: FilterItemTableViewCellProtocol, atIndex index: Int)
    func didSelectFilterItem(atIndex index: Int)

    func performContainerViewDidPressed()
    func performFilterButtonPressed()
    func cancelButtonPressed()
}

protocol FilterOrderRouterProtocol: BaseRouterProtocol {
    
}

protocol FilterOrderInteractorInputProtocol: BaseInteractorInputProtocol {
    var presenter: FilterOrderInteractorOutputProtocol? { get set }
    
}

protocol FilterOrderInteractorOutputProtocol: BaseInteractorOutputProtocol {
    
}
