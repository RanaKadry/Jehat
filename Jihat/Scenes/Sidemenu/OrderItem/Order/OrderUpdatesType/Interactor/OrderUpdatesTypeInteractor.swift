//
//  OrderUpdatesTypeInteractor.swift
//  Jihat
//
//  Created Peter Bassem on 30/09/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

// MARK: OrderUpdatesType Interactor -

class OrderUpdatesTypeInteractor: OrderUpdatesTypeInteractorInputProtocol {
    
    weak var presenter: OrderUpdatesTypeInteractorOutputProtocol?
    private let useCase: OrderUpdatesUseCase
    
    init(useCase: OrderUpdatesUseCase) {
        self.useCase = useCase
    }
    
    var userToken: String? {
        return useCase.userToken
    }
    
    func downloadDocument(fileurl: URL) {
        useCase.downloadDocument(fileurl: fileurl) { [weak self] url in
            guard let url = url else { return }
            self?.presenter?.fetchingDownloadedDocumentWithSuccess(localFileUrl: url)
        }
    }
}
