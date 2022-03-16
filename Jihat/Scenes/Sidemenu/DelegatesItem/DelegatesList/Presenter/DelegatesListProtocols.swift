//
//  DelegatesListProtocols.swift
//  Jihat
//
//  Created Ahmed Barghash on 02/10/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

// MARK: DelegatesList Protocols

protocol DelegatesListViewProtocol: BaseViewProtocol {
    var presenter: DelegatesListPresenterProtocol! { get set }
    
    func showEmptyDelegates()
    func refreshCollectionView()
}

protocol DelegatesListPresenterProtocol: BasePresenterProtocol {
    var view: DelegatesListViewProtocol? { get set }
    
    func viewDidLoad()
    
    var itemsCount: Int { get }
    func configureCollectionViewCellItem(_ cell: DelegatesListItemCollectionViewCell, atIndex index: Int)
    func didSelectCollectionViewCellItem(atIndex index: Int)
    
    func performBack()
    func performAddNewDelegate()
    
    func performEditDelegate(atIndex index: Int)
    func performShareDelegate(atIndex index: Int)
    func performDeleteDelegate(atIndex index: Int)

}

protocol DelegatesListRouterProtocol: BaseRouterProtocol {
    
    func navigateToAddNewDelegateViewController(withType type: DelegateOperationsType, newDelegateAdded: ActionCompletion?)
    func showShareActivityController(withShareText text: String)
    
}

protocol DelegatesListInteractorInputProtocol: BaseInteractorInputProtocol {
    var presenter: DelegatesListInteractorOutputProtocol? { get set }
    
    func getDelegates(commissionerRequset: BaseRequest)
    func deleteDelegate(deleteCommissionerRequest: EditDelegateRequest)
    var userToken: String? { get }
}

protocol DelegatesListInteractorOutputProtocol: BaseInteractorOutputProtocol {
    func fetchingDelegatesSuccessfully(delegates: [CommissionersResponse])
    func fetchingDelegatesWithEmptyView()
    func fetchinWithError(error: String)
    func fetchingDeleteDelegateSuccessfully(withDelegateId delegateId: String, message: String)
}
