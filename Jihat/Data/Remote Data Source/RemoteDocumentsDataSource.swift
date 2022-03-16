//
//  RemoteDocumentsDataSource.swift
//  Jihat
//
//  Created by Ahmed Barghash on 29/10/2021.
//

import Foundation

class RemoteDocumentsDataSource {
    
    func getDocuments(from apiRouter: APIRouter, completion: @escaping (Result<APIResponse<[DocumentsResponse]>, NetworkErrorType>) -> Void) {
        APIClient.performRequest(route: apiRouter).execute { response in
            completion(.success(response))
        } onFailure: { error in
            completion(.failure(error))
        }
    }
    
    func deleteDocument(from apiRouter: APIRouter, completion: @escaping (Result<APIResponse<AuthModel>, NetworkErrorType>) -> Void) {
        APIClient.performRequest(route: apiRouter).execute { response in
            completion(.success(response))
        } onFailure: { error in
            completion(.failure(error))
        }
    }
    
    func addNewDocument(from endPoint: String, addDocumentRequest: AddDocumentRequest, attachments: [String: [Data]], images: [Data], completion: @escaping (Result<APIResponse<AuthModel>, NetworkErrorType>) -> Void) {
        APIClient.uploadAttachments(endUrl: endPoint, paramsType: AddDocumentRequest.self, params: addDocumentRequest, attachments: attachments, images: images, type: APIResponse<AuthModel>.self, completion: completion)
    }
    
    func editDocument(from endPoint: String, addDocumentRequest: EditDocumentRequest, attachments: [String: [Data]], images: [Data], completion: @escaping (Result<APIResponse<AuthModel>, NetworkErrorType>) -> Void) {
        APIClient.uploadAttachments(endUrl: endPoint, paramsType: EditDocumentRequest.self, params: addDocumentRequest, attachments: attachments, images: images, type: APIResponse<AuthModel>.self, completion: completion)
    }
    
    func getDocumentDetails(from apiRouter: APIRouter, completion: @escaping (Result<APIResponse<DocumentsResponse>, NetworkErrorType>) -> Void) {
        APIClient.performRequest(route: apiRouter).execute { response in
            completion(.success(response))
        } onFailure: { error in
            completion(.failure(error))
        }
    }
    
    func downloadDocument(fileurl: URL, completion: @escaping (URL?) -> Void) {
        APIClient.openDocument(fileurl: fileurl, completion: completion)
    }
}
