//
//  DirectedEntityPresenter.swift
//  Jihat
//
//  Created by Peter Bassem on 20/12/2021.
//  Copyright © 2021 Jehat. All rights reserved.
//
//

import Foundation

// MARK: DirectedEntity Presenter -

class DirectedEntityPresenter: BasePresenter {

    weak var view: DirectedEntityViewProtocol?
    private let interactor: DirectedEntityInteractorInputProtocol
    private let router: DirectedEntityRouterProtocol
    private let departments: [DepartmentsResponse]
    private let departmentSelection: DepartmentSelection
    
    private lazy var filteredDepartments: [DepartmentsResponse] = departments
    private var isSearching = false
    
    init(view: DirectedEntityViewProtocol, interactor: DirectedEntityInteractorInputProtocol, router: DirectedEntityRouterProtocol, departments: [DepartmentsResponse], departmentSelection: @escaping DepartmentSelection) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.departments = departments
        self.departmentSelection = departmentSelection
    }
}

// MARK: - DirectedEntityPresenterProtocol
extension DirectedEntityPresenter: DirectedEntityPresenterProtocol {
    
    func viewDidLoad() {
        view?.refreshTableView()
    }
}

// MARK: - API
extension DirectedEntityPresenter: DirectedEntityInteractorOutputProtocol {
    
}

// MARK: - Selectors
extension DirectedEntityPresenter {
    
}

// MARK: - TableView Setup
extension DirectedEntityPresenter {
    
    var departmentsCount: Int {
        return isSearching ? filteredDepartments.count : departments.count
    }
    
    func configureTableViewCell(_ cell: DirectedEntityItemTableViewCellProtocol, atIndex index: Int) {
        let department = isSearching ? filteredDepartments[index] : departments[index]
        cell.set(departmentTitle: department.name ?? "")
    }
    
    func didSelectDepartmentItem(atIndex index: Int) {
        print(123)
        let department = isSearching ? filteredDepartments[index] : departments[index]
        departmentSelection(department)
        router.dismissDirectedEntityViewController()
    }
}

// MARK: - SearchBar Setup
extension DirectedEntityPresenter {
    
    func updateIsSearching(_ isSearching: Bool) {
        self.isSearching = isSearching
        if !isSearching { filteredDepartments = departments }
        view?.refreshTableView()
    }
    
    func searchItems(withSearchText searchText: String) {
        if !searchText.isEmpty {
            if !LocalizationHelper.isArabic() {
                filteredDepartments = departments.filter { ($0.name?.lowercased() ?? "").contains(searchText.lowercased()) }
            } else {
                filteredDepartments = departments.filter { ($0.name ?? "").contains(searchText) }
            }
                view?.refreshTableView()
        }
    }
}
