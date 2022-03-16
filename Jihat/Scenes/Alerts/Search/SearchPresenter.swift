//
//  SearchPresenter.swift
//  Jihat
//
//  Created by Peter Bassem on 05/03/2022.
//  Copyright © 2022 Jehat. All rights reserved.
//
//

import Foundation

// MARK: Search Presenter -

class SearchPresenter<T: Codable>: BasePresenter {

    weak var view: SearchViewProtocol?
    private let interactor: SearchInteractorInputProtocol
    private let router: SearchRouterProtocol
    private let searchItems: [T]
    private let searchItemSelection: SearchItemSelection<T>
    
    private lazy var filteredSearchItems: [T] = searchItems
    private var isSearching = false
    
    init(view: SearchViewProtocol, interactor: SearchInteractorInputProtocol, router: SearchRouterProtocol, searchItems: [T], searchItemSelection: @escaping SearchItemSelection<T>) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.searchItems = searchItems
        self.searchItemSelection = searchItemSelection
    }
}

// MARK: - SearchPresenterProtocol
extension SearchPresenter: SearchPresenterProtocol {
    
    func viewDidLoad() {
        view?.refreshTableView()
    }
}

// MARK: - API
extension SearchPresenter: SearchInteractorOutputProtocol {
    
}

// MARK: - Selectors
extension SearchPresenter {
    
    func performDismissButtonPressed() {
        router.dismissViewController()
    }
}

// MARK: TableView Setup
extension SearchPresenter {
    
    var itemsCount: Int {
        return isSearching ? filteredSearchItems.count : searchItems.count
    }
    
    func configureTableViewCell(_ cell: DirectedEntityItemTableViewCellProtocol, atIndex index: Int) {
        let item = isSearching ? filteredSearchItems[index] : searchItems[index]
        if let nationality = item as? CountriesModel {
            cell.set(departmentTitle: nationality.name ?? "")
        } else if let orderType = item as? TransactionTypesResponse {
            cell.set(departmentTitle: orderType.name ?? "")
        }
    }
    
    func didSelectItem(atIndex index: Int) {
        let item = isSearching ? filteredSearchItems[index] : searchItems[index]
        searchItemSelection(item)
        router.dismissViewController()
    }
}

// MARK: - SearchBar Setup
extension SearchPresenter {
    
    func updateIsSearching(_ isSearching: Bool) {
        self.isSearching = isSearching
        if !isSearching {
            filteredSearchItems = searchItems
        }
        view?.refreshTableView()
    }
    
    func searchItems(withSearchText searchText: String) {
        if !searchText.isEmpty {
            if let nationalities = searchItems as? [CountriesModel], var filteredNationalities = filteredSearchItems as? [CountriesModel] {
                if !LocalizationHelper.isArabic() {
                    filteredNationalities = nationalities.filter { ($0.name?.lowercased() ?? "").contains(searchText.lowercased()) }
                    self.filteredSearchItems = filteredNationalities as! [T]
                } else {
                    filteredNationalities = nationalities.filter { ($0.name ?? "").contains(searchText) }
                    self.filteredSearchItems = filteredNationalities as! [T]
                }
            } else if let orderTypes = searchItems as? [TransactionTypesResponse], var filteredOrderTypes = filteredSearchItems as? [TransactionTypesResponse] {
                if !LocalizationHelper.isArabic() {
                    filteredOrderTypes = orderTypes.filter { ($0.name?.lowercased() ?? "").contains(searchText.lowercased()) }
                    self.filteredSearchItems = filteredOrderTypes as! [T]
                } else {
                    filteredOrderTypes = orderTypes.filter { ($0.name ?? "").contains(searchText) }
                    self.filteredSearchItems = filteredOrderTypes as! [T]
                }
            }
            view?.refreshTableView()
        }
    }
}
