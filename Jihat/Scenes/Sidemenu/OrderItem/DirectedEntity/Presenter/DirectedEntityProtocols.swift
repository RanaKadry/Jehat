//
//  DirectedEntityProtocols.swift
//  Jihat
//
//  Created by Peter Bassem on 20/12/2021.
//  Copyright © 2021 Jehat. All rights reserved.
//
//

import Foundation

// MARK: DirectedEntity Protocols

protocol DirectedEntityViewProtocol: BaseViewProtocol {
    var presenter: DirectedEntityPresenterProtocol! { get set }
    
    func refreshTableView()
}

protocol DirectedEntityPresenterProtocol: BasePresenterProtocol {
    var view: DirectedEntityViewProtocol? { get set }
    
    func viewDidLoad()

    var departmentsCount: Int { get }
    func configureTableViewCell(_ cell: DirectedEntityItemTableViewCellProtocol, atIndex index: Int)
    func didSelectDepartmentItem(atIndex index: Int)
    
    func updateIsSearching(_ isSearching: Bool)
    func searchItems(withSearchText searchText: String)
}

protocol DirectedEntityRouterProtocol: BaseRouterProtocol {
    func dismissDirectedEntityViewController()
}

protocol DirectedEntityInteractorInputProtocol: BaseInteractorInputProtocol {
    var presenter: DirectedEntityInteractorOutputProtocol? { get set }
    
}

protocol DirectedEntityInteractorOutputProtocol: BaseInteractorOutputProtocol {
    
}
