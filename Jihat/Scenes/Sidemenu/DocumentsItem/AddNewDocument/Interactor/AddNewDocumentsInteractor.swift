//
//  AddNewDocumentsInteractor.swift
//  Jihat
//
//  Created Ahmed Barghash on 12/10/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

// MARK: AddNewDocuments Interactor -

class AddNewDocumentsInteractor: AddNewDocumentsInteractorInputProtocol {
    
    weak var presenter: AddNewDocumentsInteractorOutputProtocol?
    private let useCase: AddDocumentUseCase
    
    init(useCase: AddDocumentUseCase) {
        self.useCase = useCase
    }
    
    var userToken: String? {
        return useCase.userToken
    }
    
    func addNewDocument(addDocumentRequest: AddDocumentRequest, attachments: [String: [Data]], images: [Data]) {
        useCase.addNewDocument(addDocumentRequest: addDocumentRequest, attachments: attachments, images: images) { [weak self] result in
            switch result {
            case .success(let addDocumentResponse):
                if addDocumentResponse.status == true {
                    DispatchQueue.main.async {
                        self?.presenter?.fetchingAddDocumentWithSuccess(message: addDocumentResponse.message ?? "")
                    }
                } else {
                    DispatchQueue.main.async {
                        self?.presenter?.fetchingAddDocumentWithFail(error: addDocumentResponse.message ?? "")
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.presenter?.fetchingAddDocumentWithFail(error: error.rawValue.localized())
                }
            }
        }
    }
}
