//
//  AddVoiceNoteInteractor.swift
//  Jihat
//
//  Created Peter Bassem on 13/10/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

// MARK: AddVoiceNote Interactor -

class AddVoiceNoteInteractor: AddVoiceNoteInteractorInputProtocol {
    
    weak var presenter: AddVoiceNoteInteractorOutputProtocol?
    private let useCase: AddVoiceNoteUseCase
    
    init(useCase: AddVoiceNoteUseCase) {
        self.useCase = useCase
    }
    
    var userToken: String? {
        return useCase.userToken
    }
    
    func addOrderComment(addOrderCommentRequest: AddOrderCommentRequest, attachments: [String : [Data]], body: [String : Any]) {
        useCase.addOrderComment(addOrderCommentRequest: addOrderCommentRequest, attachments: attachments, body: body) { [weak self] result in
            switch result {
            case .success(let addVoiceNoteCommentResponse):
                if addVoiceNoteCommentResponse.status == true {
                    DispatchQueue.main.async {
                        self?.presenter?.fetchingAddVoiceNoteWithSuccess()
                    }
                } else {
                    DispatchQueue.main.async {
                        self?.presenter?.fetchingWithError(error: addVoiceNoteCommentResponse.message ?? "")
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
