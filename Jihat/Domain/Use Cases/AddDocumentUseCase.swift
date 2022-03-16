//
//  AddDocumentUseCase.swift
//  Jihat
//
//  Created by Peter Bassem on 05/11/2021.
//  Copyright © 2021 Jehat. All rights reserved.
//

import Foundation

class AddDocumentUseCase {
    private let userRepository: UserRepository
    private let documentRepository: DocumentRepository
    
    init(userRepository: UserRepository, documentRepository: DocumentRepository) {
        self.userRepository = userRepository
        self.documentRepository = documentRepository
    }
    
    // ------------
    // MARK: - USER
    // ------------
    var userToken: String? {
        userRepository.userToken
    }
    
    // ----------------
    // MARK: - DOCUMENT
    // ----------------
    func addNewDocument(addDocumentRequest: AddDocumentRequest, attachments: [String: [Data]], images: [Data], completion: @escaping (Result<APIResponse<AuthModel>, NetworkErrorType>) -> Void) {
        documentRepository.addNewDocument(addDocumentRequest: addDocumentRequest, attachments: attachments, images: images, completion: completion)
    }
}
