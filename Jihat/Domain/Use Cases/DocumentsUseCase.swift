//
//  DocumentsUseCase.swift
//  Jihat
//
//  Created by Ahmed Barghash on 29/10/2021.
//

import Foundation

class DocumentsUseCase {
    
    private let documentRepository: DocumentRepository
    private let userRepository: UserRepository
    
    init(documentRepository: DocumentRepository, userRepository: UserRepository) {
        self.documentRepository = documentRepository
        self.userRepository = userRepository
    }
    
    // -----------------
    // MARK: - DOCUMENTS
    // -----------------
    
    func getDocuments(documentsRequest: BaseRequest, completion: @escaping (Result<APIResponse<[DocumentsResponse]>, NetworkErrorType>) -> Void) {
        documentRepository.getDocuments(documentsRequest: documentsRequest, completion: completion)
    }
    
    // -----------------------
    // MARK: - DELETE DOCUMENT
    // -----------------------
    
    func deleteDocument(deleteDocumentRequest: DeleteDocumentRequest, completion: @escaping (Result<APIResponse<AuthModel>,NetworkErrorType>) -> Void) {
        documentRepository.deleteDocument(deleteDocumentRequest: deleteDocumentRequest, completion: completion)
    }
    
    // ------------
    // MARK: - USER
    // ------------
    var userToken: String? {
        return userRepository.userToken
    }
}
