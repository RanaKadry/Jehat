//
//  DocumentsPresenter.swift
//  Jihat
//
//  Created Ahmed Barghash on 04/10/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

// MARK: Documents Presenter -

class DocumentsPresenter: BasePresenter {

    weak var view: DocumentsViewProtocol?
    private let interactor: DocumentsInteractorInputProtocol
    private let router: DocumentsRouterProtocol
    
    private var isSearching = false
    private var documents: [DocumentsResponse] = []
    private var filteredDocuments: [DocumentsResponse] = []
    
    init(view: DocumentsViewProtocol, interactor: DocumentsInteractorInputProtocol, router: DocumentsRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
}

// MARK: - DocumentsPresenterProtocol
extension DocumentsPresenter: DocumentsPresenterProtocol {
    
    func viewDidLoad() {
        view?.showLoading()
        interactor.getDocuments(documentsRequest: BaseRequest(userToken: interactor.userToken ?? ""))
    }
}

// MARK: - API
extension DocumentsPresenter: DocumentsInteractorOutputProtocol {
    
    func fetchingDocumentsSuccessfully(documents: [DocumentsResponse]) {
        view?.hideLoading()
        self.documents = documents
        view?.refreshCollectionView()
    }
    
    func fetchingDocumentsWithEmptyData() {
        view?.hideLoading()
        view?.showEmptyDocuments()
    }
    
    func fetchinWithError(error: String) {
        view?.hideLoading()
        view?.showBottomMessage(error)
    }
    
    func fetchingDeleteDocumentSuccessfully(documentId: String, message: String) {
        view?.hideLoading()
        view?.showBottomMessage(message)
        documents = documents.filter { $0.id != documentId }
        filteredDocuments = filteredDocuments.filter { $0.id != documentId }
        let docs = isSearching ? filteredDocuments : documents
        if docs.isEmpty {
            view?.showEmptyDocuments()
        } else {
            view?.refreshCollectionView()
        }
    }
}

// MARK: - Search
extension DocumentsPresenter {
    
    func updateIsSearching(_ isSearching: Bool) {
        self.isSearching = isSearching
        view?.refreshCollectionView()
    }
    
    func searchDocuments(withSearchText searchText: String) {
        if !searchText.isEmpty {
            if !LocalizationHelper.isArabic() {
                filteredDocuments = documents.filter { ($0.englishName?.lowercased() ?? "").contains(searchText.lowercased()) }
            } else {
                filteredDocuments = documents.filter { ($0.arabicName ?? "").contains(searchText) }
            }
            if filteredDocuments.isEmpty {
                view?.showNoSearchResult()
            } else {
                view?.refreshCollectionView()
            }
        }
    }
}

// MARK: - Selectors
extension DocumentsPresenter {
    
    func performBack() {
        router.popupViewController()
    }
    
    func performAddNewDocument() {
        router.navigateToAddNewDocumentViewController { [weak self] in
            self?.view?.showLoading()
            self?.interactor.getDocuments(documentsRequest: BaseRequest(userToken: self?.interactor.userToken))
        }
    }
}

// MARK: - DocumentsCollectionView Setup
extension DocumentsPresenter {
    
    var itemsCount: Int {
        return isSearching ? filteredDocuments.count : documents.count
    }
    
    func configureCollectionViewCellItem(_ cell: DocumentsCollectionViewCellProtocol, atIndex index: Int) {
        let document = isSearching ? filteredDocuments[index] : documents[index]
        cell.set(documentArabicName: document.arabicName ?? "")
        cell.set(documentEnglishName: document.englishName ?? "")
        let docNumber = LocalizationHelper.isArabic() ? document.documentNumber?.enToArDigits : document.documentNumber?.arToEnDigits
        cell.set(documentNumber: docNumber ?? "")
        let endDateString = String(document.endDate?.split(separator: "-").last ?? "")
        cell.set(endDate: Date.localizedDate(date: endDateString))
    }
    
    func didSelectCollectionViewCellItem(atIndex index: Int) {
        print("Cell Tapped")
    }
    
    func performEditDocument(atIndex index: Int) {
        let document = isSearching ? filteredDocuments[index] : documents[index]
        router.navigateToEditDocumentViewController(withDocumentId: document.id ?? "", atIndex: index) { [weak self] updatedDocument, index in
            if self?.isSearching == true {
                self?.filteredDocuments[index] = updatedDocument
            } else {
                self?.documents[index] = updatedDocument
            }
            self?.view?.refreshCollectionView()
        }
    }
    
    func performShareDocument(atIndex index: Int) {
        let document = isSearching ? filteredDocuments[index] : documents[index]
        let textToShare = "\(document.arabicName ?? "") - \(document.englishName ?? "") - \(document.documentNumber ?? "") - \(document.endDate ?? "")"
        router.showShareActivityController(withShareText: textToShare)
    }
    
    func performDeleteDocument(atIndex index: Int) {
        let document = isSearching ? filteredDocuments[index] : documents[index]
        let documentId = document.id
        view?.showLoading()
        interactor.deleteDocument(deleteDocumentRequest: DeleteDocumentRequest(userToken: interactor.userToken, documentId: documentId))
    }
}
