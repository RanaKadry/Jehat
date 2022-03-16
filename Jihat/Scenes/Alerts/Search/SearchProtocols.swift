//
//  SearchProtocols.swift
//  Jihat
//
//  Created by Peter Bassem on 05/03/2022.
//  Copyright © 2022 Jehat. All rights reserved.
//
//

import Foundation

// MARK: Search Protocols

protocol SearchViewProtocol: BaseViewProtocol {
    var presenter: SearchPresenterProtocol! { get set }
    func refreshTableView()
}

protocol SearchPresenterProtocol: BasePresenterProtocol {
    var view: SearchViewProtocol? { get set }
    
    func viewDidLoad()
    
    var itemsCount: Int { get }
    func configureTableViewCell(_ cell: DirectedEntityItemTableViewCellProtocol, atIndex index: Int)
    func didSelectItem(atIndex index: Int)

    func updateIsSearching(_ isSearching: Bool)
    func searchItems(withSearchText searchText: String)
    
    func performDismissButtonPressed()
}

protocol SearchRouterProtocol: BaseRouterProtocol {
    
}

protocol SearchInteractorInputProtocol: BaseInteractorInputProtocol {
    var presenter: SearchInteractorOutputProtocol? { get set }
    
}

protocol SearchInteractorOutputProtocol: BaseInteractorOutputProtocol {
    
}
