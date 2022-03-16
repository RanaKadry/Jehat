//
//  NewOrderInteractor.swift
//  Jihat
//
//  Created Ahmed Barghash on 28/09/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

// MARK: NewOrder Interactor -

class NewOrderInteractor: NewOrderInteractorInputProtocol {
    
    weak var presenter: NewOrderInteractorOutputProtocol?
    private let useCase: NewOrderUseCase
    
    private var departments: [DepartmentsResponse]?
    private var priorities: [PrioritiesResponse]?
    private var error: String?
    
    init(useCase: NewOrderUseCase) {
        self.useCase = useCase
    }
    
    private func getDepartments(successCompletion: @escaping ([DepartmentsResponse]) -> Void, failResponse: @escaping (String) -> Void) {
        useCase.getDepartments { result in
            switch result {
            case .success(let departmentsResponse):
                if departmentsResponse.status == true {
                    guard let departments = departmentsResponse.data, !departments.isEmpty else { return }
                    successCompletion(departments)
                } else {
                    failResponse(departmentsResponse.message ?? "")
                }
            case .failure(let error):
                failResponse(error.rawValue.localized())
            }
        }
    }
    
    func getTransactionProperties(transactionPropertiesRequest: TransactionPropertiesRequest) {
        useCase.getTransactionProperties(transactionPropertiesRequest: transactionPropertiesRequest) { [weak self] result in
            switch result {
            case .success(let transactionPropertiesResponse):
                if transactionPropertiesResponse.status == true {
                    guard let properties = transactionPropertiesResponse.data, !properties.isEmpty else {
                        DispatchQueue.main.async {
                            self?.presenter?.fetchingEmptyPropertiesWithSuccess()
                        }
                        return
                    }
                    if properties.count == 1 {
                        properties.forEach {
                            if $0.id == "" && $0.name == "" && $0.type == "" {
                                DispatchQueue.main.async {
                                    self?.presenter?.fetchingEmptyPropertiesWithSuccess()
                                }
                            }
                        }
                    } else {
                        DispatchQueue.main.async {
                            self?.presenter?.fetchingPropertiesWithSuccess(properties: properties)
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        self?.presenter?.fetchingWithError(error: transactionPropertiesResponse.message ?? "")
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.presenter?.fetchingWithError(error: error.rawValue.localized())
                }
            }
        }
    }
    
    private func getPriorities(successCompletion: @escaping ([PrioritiesResponse]) -> Void, failCompletion: @escaping (String) -> Void) {
        useCase.getPriorities { result in
            switch result {
            case .success(let prioritiesResponse):
                if prioritiesResponse.status == true {
                    guard let priorities = prioritiesResponse.data, !priorities.isEmpty else { return }
                    successCompletion(priorities)
                } else {
                    failCompletion(prioritiesResponse.message ?? "")
                }
            case .failure(let error):
                failCompletion(error.rawValue.localized())
            }
        }
    }
    
    func getAddOrderData() {
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        getDepartments { [weak self] departments in
            dispatchGroup.leave()
            self?.departments = departments
        } failResponse: { [weak self] error in
            dispatchGroup.leave()
            self?.error = error
        }

        dispatchGroup.enter()
        getPriorities { [weak self] priorities in
            dispatchGroup.leave()
            self?.priorities = priorities
        } failCompletion: { [weak self] error in
            dispatchGroup.leave()
            self?.error = error
        }
        
        dispatchGroup.notify(queue: .main) { [weak self] in
            if let error = self?.error {
                self?.presenter?.fetchingWithError(error: error)
                return
            }
            if let departments = self?.departments {
                self?.presenter?.fetchingDepartmentsWithSuccess(departments: departments)
            }
            if let priorities = self?.priorities {
                self?.presenter?.fetchingPrioritiesWithSuccess(priorities: priorities)
            }
        }
    }
    
    func getTransactionTypes(transactionTypesRequest: TransactionTypesRequest) {
        useCase.getTransactionTypes(transactionTypesRequest: transactionTypesRequest) { [weak self] result in
            switch result {
            case .success(let transactionTypesResponse):
                if transactionTypesResponse.status == true {
                    guard let transactionTypes = transactionTypesResponse.data, !transactionTypes.isEmpty else { return }
                    DispatchQueue.main.async {
                        self?.presenter?.fetchingTransactionTypesWithSuccess(transactionTypes: transactionTypes)
                    }
                } else {
                    DispatchQueue.main.async {
                        self?.presenter?.fetchingWithError(error: transactionTypesResponse.message ?? "")
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.presenter?.fetchingWithError(error: error.rawValue.localized())
                }
            }
        }
    }
    
    func addNewOrder(addOrderRequest: AddOrderRequest, body: Data) {
        useCase.addNewOrder(addOrderRequest: addOrderRequest, body: body) { [weak self] result in
            switch result {
            case .success(let addOrderResponse):
                if addOrderResponse.status == true {
                    DispatchQueue.main.async {
                        self?.presenter?.fetchingAddOrderWithSuccess(replyId: addOrderResponse.data?.id)
                    }
                } else {
                    DispatchQueue.main.async {
                        self?.presenter?.fetchingWithError(error: addOrderResponse.message ?? "")
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.presenter?.fetchingWithError(error: error.rawValue.localized())
                }
            }
        }
    }
    
    func addOrderAttachments(addOrderAttachmentsRequest: AddOrderAttachmentsRequest, attachments: [String: [Data]], images: [Data]) {
        useCase.addOrderAttachments(addOrderAttachmentsRequest: addOrderAttachmentsRequest, attachments: attachments, images: images) { [weak self] result in
            switch result {
            case .success(let addOrderAttachmentsResponse):
                if addOrderAttachmentsResponse.status == true {
                    DispatchQueue.main.async {
                        self?.presenter?.fetchingAddOrderAttachmentsWithSuccess()
                    }
                } else {
                    DispatchQueue.main.async {
                        self?.presenter?.fetchingWithError(error: addOrderAttachmentsResponse.message ?? "")
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.presenter?.fetchingWithError(error: error.rawValue.localized())
                }
            }
        }
    }
    
    func addOrder(addOrderRequest: AddOrderRequest, addOrderBodyRequest: [String: [AddOrderBodyRequest]]) {
        useCase.addOrder(addOrderRequest: addOrderRequest, addOrderBodyRequest: addOrderBodyRequest) { result in
            switch result {
            case .success(let response):
                print(response)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    var userToken: String? {
        return useCase.userToken
    }
}
