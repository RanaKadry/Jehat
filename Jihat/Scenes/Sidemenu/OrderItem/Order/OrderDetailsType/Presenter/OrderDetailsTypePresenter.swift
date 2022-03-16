//
//  OrderDetailsTypePresenter.swift
//  Jihat
//
//  Created Peter Bassem on 30/09/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

// MARK: OrderDetailsType Presenter -

class OrderDetailsTypePresenter: BasePresenter {

    weak var view: OrderDetailsTypeViewProtocol?
    private let interactor: OrderDetailsTypeInteractorInputProtocol
    private let router: OrderDetailsTypeRouterProtocol
    private let order: UserOrdersResponse
    
    init(view: OrderDetailsTypeViewProtocol, interactor: OrderDetailsTypeInteractorInputProtocol, router: OrderDetailsTypeRouterProtocol, order: UserOrdersResponse) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.order = order
    }
    
}

// MARK: - OrderDetailsTypePresenterProtocol
extension OrderDetailsTypePresenter: OrderDetailsTypePresenterProtocol {
    
    func viewDidLoad() {
        print(order)
        
        view?.refreshScrollView()
        view?.set(orderNumber: LocalizationHelper.isArabic() ? (order.ticketId?.enToArDigits ?? "") : (order.ticketId ?? ""))
        let ticketDateString = String(order.ticketDate?.split(separator: "-").last ?? "")
        view?.set(creationDate: Date.localizedDate(date: ticketDateString))
        view?.set(status: order.status ?? "")
        let expectedDateString = String(order.expectedDate?.split(separator: "-").last ?? "")
        let dateString = String(expectedDateString.split(separator: " ").last ?? "")
        view?.set(expectedCompletionDate: Date.localizedDate(date: dateString))
        view?.set(employee: order.department ?? "")
        let employeeTextHeight = (order.department ?? "").heightForView(font: DesignSystem.Typography.defaultFont.font, width: screenWidth - 48)
        view?.set(employeeTextHeight: employeeTextHeight)
        view?.set(type: order.type ?? "")
        let typeTextHeight = (order.type ?? "").heightForView(font: DesignSystem.Typography.defaultFont.font, width: screenWidth - 48)
        view?.set(typeTextHeight: typeTextHeight)
        view?.set(subject: order.subject ?? "")
        let subjectTextHeight = (order.subject ?? "").heightForView(font: DesignSystem.Typography.defaultFont.font, width: screenWidth - 48)
        view?.set(subjectTextHeight: subjectTextHeight)
        view?.set(details: order.detatils ?? "")
        view?.updateOrderDetailsLabelHeight(details: order.detatils ?? "")
        view?.set(priority: order.priority ?? "")
        view?.set(department: order.employee ?? "")
        let departmentTextHeight = (order.employee ?? "").heightForView(font: DesignSystem.Typography.defaultFont.font, width: screenWidth - 48)
        view?.set(departmentHeight: departmentTextHeight)
    }
}

// MARK: - API
extension OrderDetailsTypePresenter: OrderDetailsTypeInteractorOutputProtocol {
    
}

// MARK: - Selectors
extension OrderDetailsTypePresenter {
    
}

// MARK: - AttatchmentsCollectionView Setup
extension OrderDetailsTypePresenter {
    
    var attatchmentsCount: Int {
        return 5
    }
    
    func configureAttatchemtCell(_ cell: AttatchmentCollectionViewCellProtocol, atIndex index: Int) {
        cell.setImage(DesignSystem.Icon.attachemtPlaceholder.rawValue)
    }
}
