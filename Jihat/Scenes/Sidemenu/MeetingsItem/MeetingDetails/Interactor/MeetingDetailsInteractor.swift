//
//  MeetingDetailsInteractor.swift
//  Jihat
//
//  Created by Ahmed Barghash on 04/11/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

// MARK: MeetingDetails Interactor -

class MeetingDetailsInteractor: MeetingDetailsInteractorInputProtocol {
    
    weak var presenter: MeetingDetailsInteractorOutputProtocol?
    private let useCase: MeetingDetailsTypeUseCase
    
    init(useCase: MeetingDetailsTypeUseCase) {
        self.useCase = useCase
    }
    
    func downloadDocument(fileurl: URL) {
        useCase.downloadDocument(fileurl: fileurl) { [weak self] url in
            guard let url = url else { return }
            self?.presenter?.fetchingDownloadedDocumentWithSuccess(localFileUrl: url)
        }
    }
}
