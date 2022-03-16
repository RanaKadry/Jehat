//
//  AddTextInteractor.swift
//  Jihat
//
//  Created Peter Bassem on 10/10/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

// MARK: AddText Interactor -

class AddTextInteractor: AddTextInteractorInputProtocol {
    
    weak var presenter: AddTextInteractorOutputProtocol?
    private let useCase: OrderAddTextUseCase
    
    
    init(useCase: OrderAddTextUseCase) {
        self.useCase = useCase
    }
    
    var userToken: String? {
        return useCase.userToken
    }
    
    func addOrderComment(addOrderCommentRequest: AddOrderCommentRequest) {
        useCase.addOrderComment(addOrderCommentRequest: addOrderCommentRequest, attachments: [:], body: [:]) { [weak self] result in
            switch result {
            case .success(let addOrderCommentResponse):
                if addOrderCommentResponse.status == true {
                    DispatchQueue.main.async {
                        self?.presenter?.fetchingAddCommentWithSuccess()
                    }
                } else {
                    DispatchQueue.main.async {
                        self?.presenter?.fetchingWithError(error: addOrderCommentResponse.message ?? "")
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
