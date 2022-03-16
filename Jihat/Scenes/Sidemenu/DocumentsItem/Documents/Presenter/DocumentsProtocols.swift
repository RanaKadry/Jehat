//
//  DocumentsProtocols.swift
//  Jihat
//
//  Created Ahmed Barghash on 04/10/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

// MARK: Documents Protocols

protocol DocumentsViewProtocol: BaseViewProtocol {
    var presenter: DocumentsPresenterProtocol! { get set }
    
    func refreshCollectionView()
    func showEmptyDocuments()
    func showNoSearchResult()
}

protocol DocumentsPresenterProtocol: BasePresenterProtocol {
    var view: DocumentsViewProtocol? { get set }
    
    func viewDidLoad()
    
    var itemsCount: Int { get }
    func configureCollectionViewCellItem(_ cell: DocumentsCollectionViewCellProtocol, atIndex index: Int)
    func didSelectCollectionViewCellItem(atIndex index: Int)
    
    func updateIsSearching(_ isSearching: Bool)
    func searchDocuments(withSearchText searchText: String)
    
    func performBack()
    func performAddNewDocument()
    func performEditDocument(atIndex index: Int)
    func performShareDocument(atIndex index: Int)
    func performDeleteDocument(atIndex index: Int)

}

protocol DocumentsRouterProtocol: BaseRouterProtocol {
    
    func navigateToAddNewDocumentViewController(successAddDocumentCompletion: @escaping ActionCompletion)
    func navigateToEditDocumentViewController(withDocumentId documentId: String, atIndex index: Int, updateDocumentCompletion: @escaping UpdateDocumentCompletion)
    func showShareActivityController(withShareText text: String)
    
}

protocol DocumentsInteractorInputProtocol: BaseInteractorInputProtocol {
    var presenter: DocumentsInteractorOutputProtocol? { get set }
    
    func getDocuments(documentsRequest: BaseRequest)
    var userToken: String? { get }
    func deleteDocument(deleteDocumentRequest: DeleteDocumentRequest)
}

protocol DocumentsInteractorOutputProtocol: BaseInteractorOutputProtocol {
    
    func fetchingDocumentsSuccessfully(documents: [DocumentsResponse])
    func fetchingDocumentsWithEmptyData()
    func fetchinWithError(error: String)
    func fetchingDeleteDocumentSuccessfully(documentId: String, message: String)
    
}
