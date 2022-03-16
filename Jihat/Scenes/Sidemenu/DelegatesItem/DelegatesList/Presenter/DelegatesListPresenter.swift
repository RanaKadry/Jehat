//
//  DelegatesListPresenter.swift
//  Jihat
//
//  Created Ahmed Barghash on 02/10/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

// MARK: DelegatesList Presenter -

class DelegatesListPresenter: BasePresenter {

    weak var view: DelegatesListViewProtocol?
    private let interactor: DelegatesListInteractorInputProtocol
    private let router: DelegatesListRouterProtocol
    
    private var delegates: [CommissionersResponse] = []
        
    init(view: DelegatesListViewProtocol, interactor: DelegatesListInteractorInputProtocol, router: DelegatesListRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
}

// MARK: - DelegatesListPresenterProtocol
extension DelegatesListPresenter: DelegatesListPresenterProtocol {
    
    func viewDidLoad() {
        view?.showLoading()
        interactor.getDelegates(commissionerRequset: BaseRequest(userToken: interactor.userToken ?? ""))
    }
    
}

// MARK: - API
extension DelegatesListPresenter: DelegatesListInteractorOutputProtocol {
    
    
    func fetchingDelegatesSuccessfully(delegates: [CommissionersResponse]) {
        view?.hideLoading()
        self.delegates = delegates
        view?.refreshCollectionView()
    }
    
    func fetchingDelegatesWithEmptyView() {
        view?.hideLoading()
        view?.showEmptyDelegates()
    }
    
    func fetchinWithError(error: String) {
        view?.hideLoading()
        view?.showBottomMessage(error)
    }
    
    func fetchingDeleteDelegateSuccessfully(withDelegateId delegateId: String, message: String) {
        view?.hideLoading()
        view?.showBottomMessage(message)
        delegates = delegates.filter { $0.id !=  delegateId }
        view?.refreshCollectionView()
    }
}

// MARK: - Selectors
extension DelegatesListPresenter {
    
    func performBack() {
        router.popupViewController()
    }
    
    func performAddNewDelegate() {
//        router.navigateToAddNewDelegateViewController(withType: .add)
        router.navigateToAddNewDelegateViewController(withType: .add) { [weak self] in
            self?.view?.showLoading()
            self?.interactor.getDelegates(commissionerRequset: BaseRequest(userToken: self?.interactor.userToken))
        }
    }
    
}

// MARK: - DelegatesListCollectionView Setup
extension DelegatesListPresenter {
    
    var itemsCount: Int {
        return delegates.count
    }

    func configureCollectionViewCellItem(_ cell: DelegatesListItemCollectionViewCell, atIndex index: Int) {
        let delegate = delegates[index]
        cell.set(delegateArabicName: delegate.arabicName ?? "")
        cell.set(delegateEnglishName: delegate.englishName ?? "")
        cell.set(delegatePhone: delegate.phone ?? "")
        cell.set(delegateEmail: delegate.email ?? "")
    }

    func didSelectCollectionViewCellItem(atIndex index: Int) {
        print("Delegates list cell tapped ...")
    }
    
    func performEditDelegate(atIndex index: Int) {
        router.navigateToAddNewDelegateViewController(withType: .update(delegates[index].id ?? "")) { [weak self] in
            self?.view?.showLoading()
            self?.interactor.getDelegates(commissionerRequset: BaseRequest(userToken: self?.interactor.userToken))
        }
    }
    
    func performShareDelegate(atIndex index: Int) {
        let delegatesData = delegates[index]
        let textToShare = "\(delegatesData.arabicName ?? "") - \(delegatesData.englishName ?? "") - \(delegatesData.phone ?? "") - \(delegatesData.email ?? "")"
        router.showShareActivityController(withShareText: textToShare)
    }
    
    func performDeleteDelegate(atIndex index: Int) {
        let delegateId = delegates[index].id
        view?.showLoading()
        interactor.deleteDelegate(deleteCommissionerRequest: EditDelegateRequest(userToken: interactor.userToken, delegateId: delegateId))
    }

}
