//
//  DelegatesListInteractor.swift
//  Jihat
//
//  Created Ahmed Barghash on 02/10/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

// MARK: DelegatesList Interactor -

class DelegatesListInteractor: DelegatesListInteractorInputProtocol {
    
    weak var presenter: DelegatesListInteractorOutputProtocol?
    private let useCase: DelegatesUseCase
    
    init(useCase: DelegatesUseCase) {
        self.useCase = useCase
    }
    
    func getDelegates(commissionerRequset: BaseRequest) {
        useCase.getCommissioners(commissionerRequest: commissionerRequset) { [weak self] (result) in
            switch result {
            case .success(let delegatesResponse):
                if delegatesResponse.status == true {
                    guard let delegates = delegatesResponse.data, !delegates.isEmpty else {
                        DispatchQueue.main.async {
                            self?.presenter?.fetchingDelegatesWithEmptyView()
                        }
                        return
                    }
                    DispatchQueue.main.async {
                        self?.presenter?.fetchingDelegatesSuccessfully(delegates: delegates)
                    }
                } else {
                    DispatchQueue.main.async {
                        self?.presenter?.fetchinWithError(error: delegatesResponse.message ?? "")
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.presenter?.fetchinWithError(error: error.rawValue.localized())
                }
            }
        }
    }
    
    func deleteDelegate(deleteCommissionerRequest: EditDelegateRequest) {
        useCase.deleteCommissioner(deleteCommissionerRequest: deleteCommissionerRequest) { [weak self] (result) in
            switch result {
            case .success(let deleteDelegateResponse):
                if deleteDelegateResponse.status == true {
                    DispatchQueue.main.async {
                        self?.presenter?.fetchingDeleteDelegateSuccessfully(withDelegateId: deleteCommissionerRequest.delegateId ?? "", message: deleteDelegateResponse.message ?? "")
                    }
                }else{
                    DispatchQueue.main.async {
                        self?.presenter?.fetchinWithError(error: deleteDelegateResponse.message ?? "")
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.presenter?.fetchinWithError(error: error.rawValue.localized())
                }
            }
        }
    }
    
    var userToken: String? {
        return useCase.userToken
    }
}
