//
//  SearchBarDelegate.swift
//  Jihat
//
//  Created by Peter Bassem on 01/11/2021.
//  Copyright © 2021 Jehat. All rights reserved.
//

import Foundation
import UIKit

class SearchBarDelegate: NSObject, UISearchBarDelegate {
    
    private let isSearching: (Bool) -> Void
    private let searchText: (String) -> Void
    
    init(isSearching: @escaping (Bool) -> Void, searchText: @escaping (String) -> Void) {
        self.isSearching = isSearching
        self.searchText = searchText
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
        isSearching(true)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.resignFirstResponder()
        isSearching(!(searchBar.text ?? "").isEmpty)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.text = ""
        isSearching(false)
        self.searchText("")
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, !searchText.isEmpty else { return }
        isSearching(!searchText.isEmpty)
        self.searchText(searchText)
        searchBar.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        isSearching(!searchText.isEmpty)
        self.searchText(searchText)
    }
}
