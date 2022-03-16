//
//  NewOrderPresenter.swift
//  Jihat
//
//  Created Ahmed Barghash on 28/09/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit
import Foundation

enum PropertyInputType: String {
    case text = "Text"
    case date = "Date"
    case singleSelection = "SDrp"
    case multiSelection  = "MDrp"
    case checkboxSingleSelection = "Checkbox"
}

// MARK: NewOrder Presenter -

class NewOrderPresenter: BasePresenter {

    weak var view: NewOrderViewProtocol?
    private let interactor: NewOrderInteractorInputProtocol
    private let router: NewOrderRouterProtocol
    private let addOrderCompletion: ActionCompletion
    
    private var entitiryDirectedTo: String?
    private var orderType: String?
    private var topic: String?
    private var orderDetails: String?
    private var attachedDocuments: String?
    private var attachedImages: String?
    private var orderPriority: String?
    
    private var departments: [DepartmentsResponse] = []
    private var departmentId: String?
    private var transactionTypes: [TransactionTypesResponse] = []
    private var transactionTypeId: String?
    private var properties: [PropertiesResponse] = []
    private var keyboardRectangleFrame: CGRect!
    private var priorities: [PrioritiesResponse] = []
    private var priorityId: String?
    private var attachmentsData: [String: [Data]] = [:]
    private var imagesData: [Data] = []
    
    init(view: NewOrderViewProtocol, interactor: NewOrderInteractorInputProtocol, router: NewOrderRouterProtocol, addOrderCompletion: @escaping ActionCompletion) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.addOrderCompletion = addOrderCompletion
    }
    
}

// MARK: - NewOrderPresenterProtocol
extension NewOrderPresenter: NewOrderPresenterProtocol {
    
    func viewDidLoad() {
        view?.showLoading()
        interactor.getAddOrderData()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
    }
    
    @objc
    private func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            keyboardRectangleFrame = keyboardRectangle
        }
    }
    
    func performObserveInputs(entity: String?, orderType: String?, topic: String?, details: String?, attachedDocuments: String?, images: String?, orderPriority: String?) {
        self.entitiryDirectedTo = entity
        self.orderType = orderType
        self.topic = topic
        self.orderDetails = details
        self.attachedDocuments = attachedDocuments
        self.attachedImages = images
        self.orderPriority = orderPriority
        
        var observeInputs: Bool?
        var requiredInputsValidation: [Bool] = []
        if !properties.isEmpty {
            properties.forEach {
                if $0.requird == true {
                    requiredInputsValidation.append(!$0.inputValues.isEmpty)
                }
            }
            properties.forEach {
                if $0.requird == true {
                    observeInputs = entity?.isEmpty == false && orderType?.isEmpty == false && topic?.isEmpty == false && details?.isEmpty == false && details != "tap_to_insert".localized() && orderPriority?.isEmpty == false && requiredInputsValidation.allSatisfy({ $0 == true })
                }
            }
        } else {
            observeInputs = entity?.isEmpty == false && orderType?.isEmpty == false && topic?.isEmpty == false && details?.isEmpty == false && details != "tap_to_insert".localized() && orderPriority?.isEmpty == false
        }
        (observeInputs ?? false) ? view?.enableSendOrderButton() : view?.disableSendOrderButton()
    }
}

// MARK: - API
extension NewOrderPresenter: NewOrderInteractorOutputProtocol {
    
    func fetchingDepartmentsWithSuccess(departments: [DepartmentsResponse]) {
        view?.hideLoading()
        self.departments = departments
        view?.refreshEntitiesPicker()
    }
    
    func fetchingTransactionTypesWithSuccess(transactionTypes: [TransactionTypesResponse]) {
        view?.enableOrderTypeTextField()
        self.transactionTypes = transactionTypes
        view?.refreshOrderTypesPicker()
    }
    
    func fetchingPropertiesWithSuccess(properties: [PropertiesResponse]) {
        self.properties = properties
        view?.refreshPropertiesCollectionView()
    }
    
    func fetchingEmptyPropertiesWithSuccess() {
        self.properties = []
        view?.refreshPropertiesCollectionView()
    }
    
    func fetchingPrioritiesWithSuccess(priorities: [PrioritiesResponse]) {
        view?.hideLoading()
        self.priorities = priorities
        view?.refreshOrderPriorityPicker()
    }
    
    func fetchingAddOrderWithSuccess(replyId: String?) {
        let addOrderAttachmentsRequest = AddOrderAttachmentsRequest(userToken: interactor.userToken, replyId: replyId)
        interactor.addOrderAttachments(addOrderAttachmentsRequest: addOrderAttachmentsRequest, attachments: attachmentsData, images: imagesData)
    }
    
    func fetchingAddOrderAttachmentsWithSuccess() {
        view?.stopLoadingOnSendOrderButton()
        router.presentAddOrderSuccessfullyViewController { [weak self] in
            self?.addOrderCompletion()
            self?.router.dismissAddOrderSuccessfullyViewController()
            self?.router.popupViewController()
        }
    }
    
    func fetchingWithError(error: String) {
        view?.hideLoading()
        view?.showBottomMessage(error)
    }
}

// MARK: - Selectors
extension NewOrderPresenter {
    
    func performBack() {
        router.popupViewController()
    }
    
    func performDirectedEntityTextFieldPressed() {
        router.presentDirectedEntitiesViewController(departments: departments) { [unowned self] department in
            self.departmentId = department.id
            self.view?.disableOrderTypeTextField()
            self.view?.clearsOrderTypeTextField()
            self.view?.resetOrderTypePicker()
            self.interactor.getTransactionTypes(transactionTypesRequest: TransactionTypesRequest(departmentId: self.departmentId))
            self.view?.setSelectedEntity(department.name ?? "")
        }
    }
    
    func performOrderTypeTextFieldPressed() {
        router.presentOrderTypeViewController(transactionTypes: transactionTypes) { [unowned self] transactionType in
            self.transactionTypeId = transactionType.id
            self.view?.setSelectedOrderType(transactionType.name ?? "")
            self.interactor.getTransactionProperties(transactionPropertiesRequest: TransactionPropertiesRequest(transactionId: transactionType.id))
        }
    }
    
    func performAttachDocuments() {
        attachmentsData.removeAll()
        router.presentDocumentsPickerMultiScreenViewController { [weak self] documentsUrls in
            documentsUrls.forEach {
                do {
                    let fileExtension = String($0.lastPathComponent.split(separator: ".").last!)
                    let urlData = try Data(contentsOf: $0)
                    
                    if fileExtension.lowercased().contains("pdf") {
                        if self?.attachmentsData["pdf"] != nil {
                            self?.attachmentsData["pdf"]?.append(urlData)
                        } else {
                            self?.attachmentsData["pdf"] = [urlData]
                        }
                    } else if fileExtension.lowercased().contains("txt") {
                        if self?.attachmentsData["txt"] != nil {
                            self?.attachmentsData["txt"]?.append(urlData)
                        } else {
                            self?.attachmentsData["txt"] = [urlData]
                        }
                    } else if fileExtension.lowercased().contains("doc") {
                        if self?.attachmentsData["doc"] != nil {
                            self?.attachmentsData["doc"]?.append(urlData)
                        } else {
                            self?.attachmentsData["doc"] = [urlData]
                        }
                    } else if fileExtension.lowercased().contains("xls") {
                        if self?.attachmentsData["xls"] != nil {
                            self?.attachmentsData["xls"]?.append(urlData)
                        } else {
                            self?.attachmentsData["xls"] = [urlData]
                        }
                    } else if fileExtension.lowercased().contains("ppt") {
                        if self?.attachmentsData["ppt"] != nil {
                            self?.attachmentsData["ppt"]?.append(urlData)
                        } else {
                            self?.attachmentsData["ppt"] = [urlData]
                        }
                    }
                } catch let error {
                    print("Failed to convert attachment to url:", error)
                }
            }
            self?.view?.setAttachedDocumentsCount(documentsCount: String(format: "%@ %@", (documentsUrls.count.localized() ?? ""), "attachments_selected".localized()))
        }
    }
    
    func performAttachImagesButtonPressed() {
        router.presentImagePickerMultiSelectViewController(imagesLimit: 5) { [weak self] images, _ in
            self?.imagesData = images.map { $0.jpegData(compressionQuality: 0.8) ?? Data() }
            self?.view?.setPickedImagesNumber(imagesNumber: String(format: "%@ %@", (images.count.localized() ?? ""), "images_selected".localized()))
        }
    }
    
    func performSendOrder(topic: String?, orderDetails: String?) {
        guard let userToken = interactor.userToken, userToken != "" else {
            router.presentActionControl(title: "login_alert".localized(), message: nil, firstActionTitle: "login".localized(), firstAction: { [weak self] in
                self?.router.navigateToLoginViewController()
            }, secondActionTitle: "cancel".localized()) { [weak self] in
                self?.router.dismissActionControl()
            }
            return
        }
        view?.startLoadingOnSendOrderButton()
        let addOrderRequest = AddOrderRequest(userToken: interactor.userToken, departmentId: departmentId, transactionId: transactionTypeId, topic: topic, orderDetails: orderDetails, orderPriorityId: priorityId)
        let addOrderBodyRequest = properties.compactMap { AddOrderBodyRequest(propertyId: $0.id, propertyValues: $0.inputValues.isEmpty ? ["0"] : $0.inputValues) }
        do {
            let bodyData = try JSONEncoder().encode(addOrderBodyRequest)
            interactor.addNewOrder(addOrderRequest: addOrderRequest, body: bodyData)
        } catch let error {
            print(error)
        }
    }
    
    func performSaveAsDraft() {
        router.presentDismissNewOrderViewController(alertPrimaryActionCompletion: { [weak self] in
            self?.router.dismissDismissNewOrderViewController()
            self?.router.popupViewController()
        }, alertSecondaryActionCompletion: { [weak self] in
            self?.router.dismissDismissNewOrderViewController()
        })
    }
}

// MARK: - EntitiesPickerView Setup
extension NewOrderPresenter {
    
    var entitiesCount: Int {
        return departments.count
    }
    
    func configureEntitiesRow(atIndex index: Int) -> String {
        return departments[index].name ?? ""
    }
    
    func didSelectEntity(atIndex index: Int) {
        departmentId = departments[index].id
        view?.disableOrderTypeTextField()
        view?.clearsOrderTypeTextField()
        view?.resetOrderTypePicker()
        interactor.getTransactionTypes(transactionTypesRequest: TransactionTypesRequest(departmentId: departmentId))
        view?.setSelectedEntity(departments[index].name ?? "")
    }
}

// MARK: - OrderTypesPickerView Setup
extension NewOrderPresenter {
    
    var orderTypesCount: Int {
        return transactionTypes.count
    }
    
    func configureOrderTypesRow(atIndex index: Int) -> String {
        return transactionTypes[index].name ?? ""
    }
    
    func didSelectOrderType(atIndex index: Int) {
        transactionTypeId = transactionTypes[index].id
        view?.setSelectedOrderType(transactionTypes[index].name ?? "")
        interactor.getTransactionProperties(transactionPropertiesRequest: TransactionPropertiesRequest(transactionId: transactionTypes[index].id))
    }
}

// MARK: - PropertiesCollectionView Setup
extension NewOrderPresenter {
    
    var propertiesCount: Int {
        return properties.count
    }
    
    func configurePropertyCell(_ cell: PropertyCollectionViewCellProtocol, atIndex index: Int) {
        let property = properties[index]
        cell.set(propertyTitle: property.name ?? "")
        if property.requird == false {
            cell.hideAsteriskLabel()
        }
        cell.set(propertyTextFieldPlaceholder: property.name ?? "")
        guard let inputType = PropertyInputType(rawValue: property.type ?? "") else {
            fatalError("Type is not definied")
        }
        if inputType != .text {
            cell.showDropDownImage()
        }
        cell.updatekeyboardFrame(frame: keyboardRectangleFrame)
        switch inputType {
        case .text:
            cell.showTextKeyboard()
        case .date:
            cell.showDatePickerView()
        case .singleSelection, .checkboxSingleSelection:
            cell.showSingleSelectionPickerView(itemsCount: property.propertyOptions?.count ?? 0, rowCongigurator: { property.propertyOptions?[$0].name ?? "" }, itemSelection: { [weak self] in
                cell.display(text: property.propertyOptions?[$0].name ?? "")
                self?.properties[$1].inputValues = [property.propertyOptions?[$0].id ?? ""]
                self?.performObserveInputs(entity: self?.entitiryDirectedTo, orderType: self?.orderType, topic: self?.topic, details: self?.orderDetails, attachedDocuments: self?.attachedDocuments, images: self?.attachedImages, orderPriority: self?.orderPriority)
            })
        case .multiSelection:
            cell.showMultiSelectionDropDown(itemsCount: property.propertyOptions?.count ?? 0) { cell, index in
                cell.set(filterTitle: property.propertyOptions?[index].name ?? "")
                cell.updateFilterTitleLabelLeadingConstraint()
                cell.updateFilterTitleLabelTrailingConstraint()
                if property.inputValues.contains(property.propertyOptions?[index].id ?? "") {
                    cell.showCheckMark()
                } else {
                    cell.removeCheckMark()
                }
            } rowSelector: { [unowned self] in
                let selectedPropertyOptionId = property.propertyOptions?[$0].id ?? ""
                if !self.properties[$1].inputValues.contains(selectedPropertyOptionId) {
                    self.properties[$1].inputValues.append(selectedPropertyOptionId)
                } else {
                    self.properties[$1].inputValues = self.properties[$1].inputValues.filter { $0 != selectedPropertyOptionId }
                }
                cell.multiSelectionPropertyOptionsTableView()
                print(self.properties[$1].inputValues)
                performObserveInputs(entity: entitiryDirectedTo, orderType: orderType, topic: topic, details: orderDetails, attachedDocuments: attachedDocuments, images: attachedImages, orderPriority: orderPriority)
            }
        }
    }
    
    func performPropertyTextInput(inputString: String, atIndex index: Int) {
        if inputString == "" {
            properties[index].inputValues.remove(at: 0)
        } else {
            properties[index].inputValues = [inputString]
        }
        performObserveInputs(entity: entitiryDirectedTo, orderType: orderType, topic: topic, details: orderDetails, attachedDocuments: attachedDocuments, images: attachedImages, orderPriority: orderPriority)
    }
    
    func performPropertyDateInput(_ cell: PropertyCollectionViewCellProtocol, date: Date, atIndex index: Int) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormates.daySlashMonthSlashYear.rawValue
        let formattedDate = dateFormatter.string(from: date)
        properties[index].inputValues = [formattedDate]
        cell.display(text: formattedDate)
        performObserveInputs(entity: entitiryDirectedTo, orderType: orderType, topic: topic, details: orderDetails, attachedDocuments: attachedDocuments, images: attachedImages, orderPriority: orderPriority)
    }
}

// MARK: - OrderPriorityPickerView Setup
extension NewOrderPresenter {
    
    var orderPriorityCount: Int {
        return priorities.count
    }
    
    func configureOrderPriorityRow(atIndex index: Int) -> String {
        return priorities[index].name ?? ""
    }
    
    func didSelectOrderPriority(atIndex index: Int) {
        priorityId = priorities[index].id
        view?.setSelectedOrderPriority(priorities[index].name)
    }
}
