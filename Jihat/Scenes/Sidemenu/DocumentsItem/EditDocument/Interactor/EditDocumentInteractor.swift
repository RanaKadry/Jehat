//
//  EditDocumentInteractor.swift
//  Jihat
//
//  Created Ahmed Barghash on 13/10/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

// MARK: EditDocument Interactor -

class EditDocumentInteractor: EditDocumentInteractorInputProtocol {
    
    weak var presenter: EditDocumentInteractorOutputProtocol?
    private let useCase: EditDocumentUseCase
    
    init(useCase: EditDocumentUseCase) {
        self.useCase = useCase
    }
    
    var userToken: String? {
        return useCase.userToken
    }
    
    func getDocumentDetails(documentDetailsRequest: DocumentDetailsRequest) {
        useCase.getDocumentDetails(documentDetailsRequest: documentDetailsRequest) { [weak self] result in
            switch result {
            case .success(let documentDetailsResponse):
                if documentDetailsResponse.status == true {
                    guard let document = documentDetailsResponse.data else { return }
                    DispatchQueue.main.async {
                        self?.presenter?.fetchingDocumentDetailsWithSuccess(document: document)
                    }
                } else {
                    DispatchQueue.main.async {
                        self?.presenter?.fetchingWithError(error: documentDetailsResponse.message ?? "")
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.presenter?.fetchingWithError(error: error.rawValue.localized())
                }
            }
        }
    }
    
    func downloadDocument(fileurl: URL) {
        print(fileurl)
        if "\(fileurl)".contains("file://") {
            presenter?.fetchingDownloadedDocumentWithSuccess(localFileUrl: fileurl)
        } else {
            useCase.downloadDocument(fileurl: fileurl) { [weak self] url in
                guard let url = url else { return }
                self?.presenter?.fetchingDownloadedDocumentWithSuccess(localFileUrl: url)
            }
        }
    }
    
    func editDocument(addDocumentRequest: EditDocumentRequest, attachments: [String: [Data]], images: [Data]) {
        useCase.editDocument(addDocumentRequest: addDocumentRequest, attachments: attachments, images: images) { [weak self] result in
            switch result {
            case .success(let addDocumentResponse):
                if addDocumentResponse.status == true {
                    DispatchQueue.main.async {
                        self?.presenter?.fetchingEditDocumentWithSuccess(message: addDocumentResponse.message ?? "")
                    }
                } else {
                    DispatchQueue.main.async {
                        self?.presenter?.fetchingWithError(error: addDocumentResponse.message ?? "")
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
