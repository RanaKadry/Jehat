//
//  DocumentRepositoryImp.swift
//  Jihat
//
//  Created by Ahmed Barghash on 29/10/2021.
//

import Foundation

class DocumentRepositoryImp: DocumentRepository {
    
    private let remoteDocumentsDataSource = RemoteDocumentsDataSource()
    
    func getDocuments(documentsRequest: BaseRequest, completion: @escaping (Result<APIResponse<[DocumentsResponse]>, NetworkErrorType>) -> Void) {
        remoteDocumentsDataSource.getDocuments(from: .getDocuments(documentsRequest: documentsRequest), completion: completion)
    }
    
    func deleteDocument(deleteDocumentRequest: DeleteDocumentRequest, completion: @escaping (Result<APIResponse<AuthModel>, NetworkErrorType>) -> Void) {
        remoteDocumentsDataSource.deleteDocument(from: .deleteDocument(deleteDocumentRequest: deleteDocumentRequest), completion: completion)
    }
    
    func addNewDocument(addDocumentRequest: AddDocumentRequest, attachments: [String: [Data]], images: [Data], completion: @escaping (Result<APIResponse<AuthModel>, NetworkErrorType>) -> Void) {
        remoteDocumentsDataSource.addNewDocument(from: KNetworkConstants.EndPoint.addDocument.rawValue, addDocumentRequest: addDocumentRequest, attachments: attachments, images: images, completion: completion)
    }
    
    func editDocument(addDocumentRequest: EditDocumentRequest, attachments: [String: [Data]], images: [Data], completion: @escaping (Result<APIResponse<AuthModel>, NetworkErrorType>) -> Void) {
        remoteDocumentsDataSource.editDocument(from: KNetworkConstants.EndPoint.editDocument.rawValue, addDocumentRequest: addDocumentRequest, attachments: attachments, images: images, completion: completion)
    }
    
    func getDocumentDetails(documentDetailsRequest: DocumentDetailsRequest, completion: @escaping (Result<APIResponse<DocumentsResponse>, NetworkErrorType>) -> Void) {
        remoteDocumentsDataSource.getDocumentDetails(from: .getDocumentDetails(documentDetailsRequest: documentDetailsRequest), completion: completion)
    }
    
    func downloadDocument(fileurl: URL, completion: @escaping (URL?) -> Void) {
        remoteDocumentsDataSource.downloadDocument(fileurl: fileurl, completion: completion)
    }
}
