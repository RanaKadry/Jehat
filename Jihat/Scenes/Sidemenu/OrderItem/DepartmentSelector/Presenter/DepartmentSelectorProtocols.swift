//
//  DepartmentSelectorProtocols.swift
//  Jihat
//
//  Created by Peter Bassem on 20/12/2021.
//  Copyright © 2021 Jehat. All rights reserved.
//
//

import Foundation

// MARK: DepartmentSelector Protocols

protocol DepartmentSelectorViewProtocol: BaseViewProtocol {
    var presenter: DepartmentSelectorPresenterProtocol! { get set }
    
    func refreshTableView()
}

protocol DepartmentSelectorPresenterProtocol: BasePresenterProtocol {
    var view: DepartmentSelectorViewProtocol? { get set }
    
    func viewDidLoad()

    var departmentsCount: Int { get }
    func configureTableViewCell(_ cell: DirectedEntityItemTableViewCellProtocol, atIndex index: Int)
    func didSelectDepartmentItem(atIndex index: Int)
    
    func updateIsSearching(_ isSearching: Bool)
    func searchItems(withSearchText searchText: String)
    
    func performDismissButtonPressed()
}

protocol DepartmentSelectorRouterProtocol: BaseRouterProtocol {
    
}

protocol DepartmentSelectorInteractorInputProtocol: BaseInteractorInputProtocol {
    var presenter: DepartmentSelectorInteractorOutputProtocol? { get set }
    
}

protocol DepartmentSelectorInteractorOutputProtocol: BaseInteractorOutputProtocol {
    
}
