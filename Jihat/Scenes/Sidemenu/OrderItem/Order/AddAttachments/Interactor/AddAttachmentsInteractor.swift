//
//  AddAttachmentsInteractor.swift
//  Jihat
//
//  Created by Peter Bassem on 03/12/2021.
//  Copyright © 2021 Jehat. All rights reserved.
//
//

import Foundation

// MARK: AddAttachments Interactor -

class AddAttachmentsInteractor: AddAttachmentsInteractorInputProtocol {
    
    weak var presenter: AddAttachmentsInteractorOutputProtocol?
    private let useCase: OrderAddAttachmentUseCase
    
    init(useCase: OrderAddAttachmentUseCase) {
        self.useCase = useCase
    }
    
    var userToken: String? {
        return useCase.userToken
    }
    
    func addOrderComment(addOrderCommentRequest: AddOrderCommentRequest, attachments: [String: [Data]], body: [String: Any], images: [Data]) {
        useCase.addOrderComment(addOrderCommentRequest: addOrderCommentRequest, attachments: attachments, body: body, images: images) { [weak self] result in
            switch result {
            case .success(let addOrderCommentResponse):
                if addOrderCommentResponse.status == true {
                    DispatchQueue.main.async {
                        self?.presenter?.fetchingAddAttachmentsWithSuccess()
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
