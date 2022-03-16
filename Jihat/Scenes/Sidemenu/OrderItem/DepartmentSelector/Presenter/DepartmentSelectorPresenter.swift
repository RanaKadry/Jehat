//
//  DepartmentSelectorPresenter.swift
//  Jihat
//
//  Created by Peter Bassem on 20/12/2021.
//  Copyright © 2021 Jehat. All rights reserved.
//
//

import Foundation

// MARK: DepartmentSelector Presenter -

class DepartmentSelectorPresenter: BasePresenter {

    weak var view: DepartmentSelectorViewProtocol?
    private let interactor: DepartmentSelectorInteractorInputProtocol
    private let router: DepartmentSelectorRouterProtocol
    private let departments: [DepartmentsResponse]
    private let departmentSelection: DepartmentSelection
    
    private lazy var filteredDepartments: [DepartmentsResponse] = departments
    private var isSearching = false
    
    init(view: DepartmentSelectorViewProtocol, interactor: DepartmentSelectorInteractorInputProtocol, router: DepartmentSelectorRouterProtocol, departments: [DepartmentsResponse], departmentSelection: @escaping DepartmentSelection) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.departments = departments
        self.departmentSelection = departmentSelection
    }
}

// MARK: - DepartmentSelectorPresenterProtocol
extension DepartmentSelectorPresenter: DepartmentSelectorPresenterProtocol {
    
    func viewDidLoad() {
        view?.refreshTableView()
    }
}

// MARK: - API
extension DepartmentSelectorPresenter: DepartmentSelectorInteractorOutputProtocol {
    
}

// MARK: - Selectors
extension DepartmentSelectorPresenter {
    
    func performDismissButtonPressed() {
        router.dismissViewController()
    }
}

// MARK: - TableView Setup
extension DepartmentSelectorPresenter {
    
    var departmentsCount: Int {
        return isSearching ? filteredDepartments.count : departments.count
    }
    
    func configureTableViewCell(_ cell: DirectedEntityItemTableViewCellProtocol, atIndex index: Int) {
        let department = isSearching ? filteredDepartments[index] : departments[index]
        cell.set(departmentTitle: department.name ?? "")
    }
    
    func didSelectDepartmentItem(atIndex index: Int) {
        let department = isSearching ? filteredDepartments[index] : departments[index]
        departmentSelection(department)
        router.dismissViewController()
    }
}

// MARK: - SearchBar Setup
extension DepartmentSelectorPresenter {
    
    func updateIsSearching(_ isSearching: Bool) {
        self.isSearching = isSearching
        if !isSearching {
            filteredDepartments = departments
        } 
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
