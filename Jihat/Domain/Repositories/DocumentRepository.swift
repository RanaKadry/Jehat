//
//  DocumentRepository.swift
//  Jihat
//
//  Created by Ahmed Barghash on 29/10/2021.
//

import Foundation

protocol DocumentRepository {
    func getDocuments(documentsRequest: BaseRequest, completion: @escaping (Result<APIResponse<[DocumentsResponse]>, NetworkErrorType>) -> Void)
    func deleteDocument(deleteDocumentRequest: DeleteDocumentRequest, completion: @escaping (Result<APIResponse<AuthModel>,NetworkErrorType>) -> Void)
    func addNewDocument(addDocumentRequest: AddDocumentRequest, attachments: [String: [Data]], images: [Data], completion: @escaping (Result<APIResponse<AuthModel>, NetworkErrorType>) -> Void)
    func editDocument(addDocumentRequest: EditDocumentRequest, attachments: [String: [Data]], images: [Data], completion: @escaping (Result<APIResponse<AuthModel>, NetworkErrorType>) -> Void)
    func getDocumentDetails(documentDetailsRequest: DocumentDetailsRequest, completion: @escaping (Result<APIResponse<DocumentsResponse>, NetworkErrorType>) -> Void)
    func downloadDocument(fileurl: URL, completion: @escaping (URL?) -> Void)
}
