//
//  NewOrderProtocols.swift
//  Jihat
//
//  Created Ahmed Barghash on 28/09/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

// MARK: NewOrder Protocols

protocol NewOrderViewProtocol: BaseViewProtocol {
    var presenter: NewOrderPresenterProtocol! { get set }
    
    func refreshEntitiesPicker()
    func setSelectedEntity(_ entity: String?)
    func disableOrderTypeTextField()
    func enableOrderTypeTextField()
    func clearsOrderTypeTextField()
    func resetOrderTypePicker()
    func refreshOrderTypesPicker()
    func setSelectedOrderType(_ orderType: String?)
    func refreshPropertiesCollectionView()
    func setAttachedDocumentsCount(documentsCount: String)
    func setPickedImagesNumber(imagesNumber: String)
    func refreshOrderPriorityPicker()
    func setSelectedOrderPriority(_ orderPriority: String?)
    func enableSendOrderButton()
    func disableSendOrderButton()
    func startLoadingOnSendOrderButton()
    func stopLoadingOnSendOrderButton()
}

protocol NewOrderPresenterProtocol: BasePresenterProtocol {
    var view: NewOrderViewProtocol? { get set }
    
    func viewDidLoad()
    
    
    func performObserveInputs(entity: String?, orderType: String?, topic: String?, details: String?, attachedDocuments: String?, images: String?, orderPriority: String?)
    
    var entitiesCount: Int { get }
    func configureEntitiesRow(atIndex index: Int) -> String
    func didSelectEntity(atIndex index: Int)
    
    var orderTypesCount: Int { get }
    func configureOrderTypesRow(atIndex index: Int) -> String
    func didSelectOrderType(atIndex index: Int)
    
    var propertiesCount: Int { get }
    func configurePropertyCell(_ cell: PropertyCollectionViewCellProtocol, atIndex index: Int)
    func performPropertyTextInput(inputString: String, atIndex index: Int)
    func performPropertyDateInput(_ cell: PropertyCollectionViewCellProtocol, date: Date, atIndex index: Int)
    
    var orderPriorityCount: Int { get }
    func configureOrderPriorityRow(atIndex index: Int) -> String
    func didSelectOrderPriority(atIndex index: Int)
    
    func performBack()
    func performDirectedEntityTextFieldPressed()
    func performOrderTypeTextFieldPressed()
    func performAttachDocuments()
    func performAttachImagesButtonPressed()
    func performSendOrder(topic: String?, orderDetails: String?)
    func performSaveAsDraft()
}

protocol NewOrderRouterProtocol: BaseRouterProtocol {
    func presentDismissNewOrderViewController(alertPrimaryActionCompletion: @escaping ActionCompletion, alertSecondaryActionCompletion: @escaping ActionCompletion)
    func dismissDismissNewOrderViewController()
    func presentAddOrderSuccessfullyViewController(alertActionCompletion: @escaping ActionCompletion)
    func dismissAddOrderSuccessfullyViewController()
    func presentDirectedEntitiesViewController(departments: [DepartmentsResponse], departmentSelection: @escaping DepartmentSelection)
    func presentOrderTypeViewController(transactionTypes: [TransactionTypesResponse], transactionSelection: @escaping SearchItemSelection<TransactionTypesResponse>)
    func navigateToLoginViewController()
}

protocol NewOrderInteractorInputProtocol: BaseInteractorInputProtocol {
    var presenter: NewOrderInteractorOutputProtocol? { get set }
    
    var userToken: String? { get }
    func getAddOrderData()
    func getTransactionTypes(transactionTypesRequest: TransactionTypesRequest)
    func getTransactionProperties(transactionPropertiesRequest: TransactionPropertiesRequest)
    func addNewOrder(addOrderRequest: AddOrderRequest, body: Data)
    func addOrderAttachments(addOrderAttachmentsRequest: AddOrderAttachmentsRequest, attachments: [String: [Data]], images: [Data])
    func addOrder(addOrderRequest: AddOrderRequest, addOrderBodyRequest: [String: [AddOrderBodyRequest]])
}

protocol NewOrderInteractorOutputProtocol: BaseInteractorOutputProtocol {
    func fetchingDepartmentsWithSuccess(departments: [DepartmentsResponse])
    func fetchingTransactionTypesWithSuccess(transactionTypes: [TransactionTypesResponse])
    func fetchingPropertiesWithSuccess(properties: [PropertiesResponse])
    func fetchingEmptyPropertiesWithSuccess()
    func fetchingPrioritiesWithSuccess(priorities: [PrioritiesResponse])
    func fetchingAddOrderWithSuccess(replyId: String?)
    func fetchingAddOrderAttachmentsWithSuccess()
    func fetchingWithError(error: String)
}
