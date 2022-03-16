//
//  AddNewDelegateInteractor.swift
//  Jihat
//
//  Created Ahmed Barghash on 02/10/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

// MARK: AddNewDelegate Interactor -

class AddNewDelegateInteractor: AddNewDelegateInteractorInputProtocol {
    
    weak var presenter: AddNewDelegateInteractorOutputProtocol?
    private let useCase: AddDelegateUseCase
    private let singleUseCase: SingleDelegateUseCase
    
    init(useCase: AddDelegateUseCase, singleUseCase: SingleDelegateUseCase) {
        self.useCase = useCase
        self.singleUseCase = singleUseCase
    }
    
    func getSingleDelegate(singleCommissionerRequest: EditDelegateRequest) {
        singleUseCase.getSingleCommissioner(getSingleCommissionerRequest: singleCommissionerRequest) { [weak self] (result) in
            switch result {
            case .success(let singleDelegateResponse):
                if singleDelegateResponse.status == true {
                    guard let delegate = singleDelegateResponse.data else { return }
                    DispatchQueue.main.async {
                        self?.presenter?.fetchingSingleDelegateWihSuccess(delegate: delegate)
                    }
                } else {
                    DispatchQueue.main.async {
                        self?.presenter?.fetchinWithError(error: singleDelegateResponse.message ?? "")
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.presenter?.fetchinWithError(error: error.rawValue.localized())
                }
            }
        }
    }
    
    func addDelegate(addCommisionerRequest: AddDelegateRequest) {
        useCase.addCommissioner(addCommissionerRequest: addCommisionerRequest) { [weak self] (result) in
            switch result {
            case .success(let addDelegateResponse):
                if addDelegateResponse.status == true {
                    DispatchQueue.main.async {
                        self?.presenter?.fetchingAddDelegateSuccessfully(message: addDelegateResponse.message ?? "")
                    }
                } else {
                    DispatchQueue.main.async {
                        self?.presenter?.fetchinWithError(error: addDelegateResponse.message ?? "")
                    }
                }
                print(addDelegateResponse)
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.presenter?.fetchinWithError(error: error.rawValue.localized())
                }
            }
        }
    }
    
    func updateDelegate(updateCommissionerRequest: UpdateDelegateRequest) {
        useCase.updateCommissioner(updateCommissionerRequest: updateCommissionerRequest) { [weak self] (result) in
            switch result {
            case .success(let updateDelegateRespose):
                if updateDelegateRespose.status == true {
                    DispatchQueue.main.async {
                        self?.presenter?.fetchingAddDelegateSuccessfully(message: updateDelegateRespose.message ?? "")
                    }
                } else {
                    DispatchQueue.main.async {
                        self?.presenter?.fetchinWithError(error: updateDelegateRespose.message ?? "")
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
