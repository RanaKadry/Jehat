//
//  EditDocumentUseCase.swift
//  Jihat
//
//  Created by Peter Bassem on 06/11/2021.
//  Copyright © 2021 Jehat. All rights reserved.
//

import Foundation


class EditDocumentUseCase {
    private let userRepoistory: UserRepository
    private let documentRepository: DocumentRepository
    
    init(userRepoistory: UserRepository, documentRepository: DocumentRepository) {
        self.userRepoistory = userRepoistory
        self.documentRepository = documentRepository
    }
    
    // ------------
    // MARK: - USER
    // ------------
    var userToken: String? {
        return userRepoistory.userToken
    }
    
    // ----------------
    // MARK: - DOCUEMNT
    // ----------------
    func getDocumentDetails(documentDetailsRequest: DocumentDetailsRequest, completion: @escaping (Result<APIResponse<DocumentsResponse>, NetworkErrorType>) -> Void) {
        documentRepository.getDocumentDetails(documentDetailsRequest: documentDetailsRequest, completion: completion)
    }
    
    func downloadDocument(fileurl: URL, completion: @escaping (URL?) -> Void) {
        documentRepository.downloadDocument(fileurl: fileurl, completion: completion)
    }
    
    func editDocument(addDocumentRequest: EditDocumentRequest, attachments: [String: [Data]], images: [Data], completion: @escaping (Result<APIResponse<AuthModel>, NetworkErrorType>) -> Void) {
        documentRepository.editDocument(addDocumentRequest: addDocumentRequest, attachments: attachments, images: images, completion: completion)
    }
}
