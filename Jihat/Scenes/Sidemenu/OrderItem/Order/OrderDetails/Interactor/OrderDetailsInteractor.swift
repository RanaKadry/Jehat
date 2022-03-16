//
//  OrderDetailsInteractor.swift
//  Jihat
//
//  Created Peter Bassem on 29/09/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

// MARK: OrderDetails Interactor -

class OrderDetailsInteractor: OrderDetailsInteractorInputProtocol {
    
    weak var presenter: OrderDetailsInteractorOutputProtocol?
    private let useCase: OrderDetailsUseCase
    
    private var order: UserOrdersResponse?
    private var orderComments: [UserOrderCommentsResponse]?
    private var error: String?
    
    init(useCase: OrderDetailsUseCase) {
        self.useCase = useCase
    }
    
    var userToken: String? {
        return useCase.userToken
    }
    
    private func getOrderDetails(userOrderDetailsRequest: UserOrderDetailsRequest, successCompletion: @escaping (UserOrdersResponse) -> Void, failCompletion: @escaping (String) -> Void) {
        useCase.getOrderDetails(userOrderDetailsRequest: userOrderDetailsRequest) { result in
            switch result {
            case .success(let userOrderDetailsResponse):
                if userOrderDetailsResponse.status == true {
                    guard let order = userOrderDetailsResponse.data else { return }
                    successCompletion(order)
                } else {
                    failCompletion(userOrderDetailsResponse.message ?? "")
                }
            case .failure(let error):
                failCompletion(error.rawValue.localized())
            }
        }
    }
    
    func getOrderDetailsComments(userORderDetailsCommentsRequest: UserOrderDetailsRequest, successCompletion: @escaping ([UserOrderCommentsResponse]) -> Void, failCompletion: @escaping (String) -> Void) {
        useCase.getOrderDetailsComments(userORderDetailsCommentsRequest: userORderDetailsCommentsRequest) { result in
            switch result {
            case .success(let userOrderDetailsComments):
                if userOrderDetailsComments.status == true {
                    guard let orderComments = userOrderDetailsComments.data else { return }
                    successCompletion(orderComments)
                } else {
                    failCompletion(userOrderDetailsComments.message ?? "")
                }
            case .failure(let error):
                failCompletion(error.rawValue.localized())
            }
        }
    }
    
    func getOrderDetailsData(userOrderDetailsRequest: UserOrderDetailsRequest) {
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        getOrderDetails(userOrderDetailsRequest: userOrderDetailsRequest) { [weak self] order in
            dispatchGroup.leave()
            self?.order = order
        } failCompletion: { [weak self] error in
            dispatchGroup.leave()
            self?.error = error
        }
        
        dispatchGroup.enter()
        getOrderDetailsComments(userORderDetailsCommentsRequest: userOrderDetailsRequest) { [weak self] orderComments in
            dispatchGroup.leave()
            self?.orderComments = orderComments
        } failCompletion: { [weak self] error in
            dispatchGroup.leave()
            self?.error = error
        }

        dispatchGroup.notify(queue: .main) { [weak self] in
            if let error = self?.error {
                self?.presenter?.fetchingWithError(error: error)
                return
            }
            if let order = self?.order {
                self?.presenter?.fetchingOrderDetailsWithSuccess(order: order)
            }
            if let orderComments = self?.orderComments {
                self?.presenter?.fetchingOrderDetailsCommentsWithSuccess(orderComments: orderComments)
            }
            self?.presenter?.finishFetchingOrderDetailsData()
        }
    }
    
    func getOrderDetailsComments(userORderDetailsCommentsRequest: UserOrderDetailsRequest) {
        useCase.getOrderDetailsComments(userORderDetailsCommentsRequest: userORderDetailsCommentsRequest) { [weak self] result in
            switch result {
            case .success(let userOrderDetailsComments):
                if userOrderDetailsComments.status == true {
                    guard let orderComments = userOrderDetailsComments.data else { return }
                    DispatchQueue.main.async {
                        self?.presenter?.fetchingUpdatedOrderDetailsCommentsWithSuccess(orderComments: orderComments)
                    }
                } else {
                    DispatchQueue.main.async {
                        self?.presenter?.fetchingWithError(error: userOrderDetailsComments.message ?? "")
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.presenter?.fetchingWithError(error: error.rawValue.localized())
                }
            }
        }
    }
}
