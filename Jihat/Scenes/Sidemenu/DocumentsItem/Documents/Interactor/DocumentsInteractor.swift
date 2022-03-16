//
//  DocumentsInteractor.swift
//  Jihat
//
//  Created Ahmed Barghash on 04/10/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

// MARK: Documents Interactor -

class DocumentsInteractor: DocumentsInteractorInputProtocol {
    
    weak var presenter: DocumentsInteractorOutputProtocol?
    private let useCase: DocumentsUseCase
    
    init(useCase: DocumentsUseCase){
        self.useCase = useCase
    }
    
    func getDocuments(documentsRequest: BaseRequest) {
        useCase.getDocuments(documentsRequest: documentsRequest) { [weak self] (result) in
            switch result {
            case .success(let documentsResponse):
                if documentsResponse.status == true {
                    guard let documents = documentsResponse.data, !documents.isEmpty else {
                        self?.presenter?.fetchingDocumentsWithEmptyData()
                        return }
                    DispatchQueue.main.async {
                        self?.presenter?.fetchingDocumentsSuccessfully(documents: documents)
                    }
                } else {
                    DispatchQueue.main.async {
                        self?.presenter?.fetchinWithError(error: documentsResponse.message ?? "")
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.presenter?.fetchinWithError(error: error.rawValue.localized())
                }
            }
        }
    }
    
    func deleteDocument(deleteDocumentRequest: DeleteDocumentRequest) {
        useCase.deleteDocument(deleteDocumentRequest: deleteDocumentRequest) { [weak self] (result) in
            switch result {
            case .success(let deleteDocumentResponse):
                if deleteDocumentResponse.status == true {
                    self?.presenter?.fetchingDeleteDocumentSuccessfully(documentId: deleteDocumentRequest.documentId ?? "", message: deleteDocumentResponse.message ?? "")
                } else {
                    DispatchQueue.main.async {
                        self?.presenter?.fetchinWithError(error: deleteDocumentResponse.message ?? "")
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
