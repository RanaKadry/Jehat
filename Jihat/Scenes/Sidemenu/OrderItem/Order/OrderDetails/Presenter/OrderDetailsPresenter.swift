//
//  OrderDetailsPresenter.swift
//  Jihat
//
//  Created Peter Bassem on 29/09/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

// MARK: OrderDetails Presenter -

class OrderDetailsPresenter: BasePresenter {

    weak var view: OrderDetailsViewProtocol?
    private let interactor: OrderDetailsInteractorInputProtocol
    private let router: OrderDetailsRouterProtocol
    private let orderId: String?
    
    private var orderDetailsType: OrderDetailsTypes = .orderDetails
    private var orderComments: [UserOrderCommentsResponse]?
    
    init(view: OrderDetailsViewProtocol, interactor: OrderDetailsInteractorInputProtocol, router: OrderDetailsRouterProtocol, orderId: String?) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.orderId = orderId
    }
}

// MARK: - OrderDetailsPresenterProtocol
extension OrderDetailsPresenter: OrderDetailsPresenterProtocol {
    
    func viewDidLoad() {
        print(orderId)
        view?.showLoading()
        interactor.getOrderDetailsData(userOrderDetailsRequest: UserOrderDetailsRequest(userToken: interactor.userToken, orderId: orderId))
    }
}

// MARK: - API
extension OrderDetailsPresenter: OrderDetailsInteractorOutputProtocol {
    
    func fetchingOrderDetailsWithSuccess(order: UserOrdersResponse) {
        router.addOrderDetailsTypeViewController(order: order)
    }
    
    func fetchingOrderDetailsCommentsWithSuccess(orderComments: [UserOrderCommentsResponse]) {
        self.orderComments = orderComments
        router.addOrderUpdatesTypeViewController(orderComments: orderComments) { [weak self] in
            self?.router.presentAddTextViewController(orderId: self?.orderId) { [weak self] in
                self?.interactor.getOrderDetailsComments(userORderDetailsCommentsRequest: UserOrderDetailsRequest(userToken: self?.interactor.userToken, orderId: self?.orderId))
            }
        } addVoiceNoteAction: { [weak self] in
            self?.router.presentAddVoiceNoteViewController(orderId: self?.orderId) { [weak self] in
                self?.interactor.getOrderDetailsComments(userORderDetailsCommentsRequest: UserOrderDetailsRequest(userToken: self?.interactor.userToken, orderId: self?.orderId))
            }
        } addAttachmentAction: { [weak self] in
            self?.router.presentAddAttachmentViewController(orderId: self?.orderId) { [weak self] in
                self?.interactor.getOrderDetailsComments(userORderDetailsCommentsRequest: UserOrderDetailsRequest(userToken: self?.interactor.userToken, orderId: self?.orderId))
            }
        }
    }
    
    func fetchingUpdatedOrderDetailsCommentsWithSuccess(orderComments: [UserOrderCommentsResponse]) {
        router.showOrderUpdatesTypeView(orderComments: orderComments)
    }
    
    func fetchingWithError(error: String) {
        view?.hideLoading()
        view?.showBottomMessage(error)
    }
    
    func finishFetchingOrderDetailsData() {
        view?.hideLoading()
        view?.refreshAppBarCollectionView()
        view?.refreshView()
    }
}

// MARK: - Selectors
extension OrderDetailsPresenter {
 
    func performBack() {
        router.popupViewController()
        Player.shared.stop()
    }
}

// MARK: - NavigationBarCollectionView Setup
extension OrderDetailsPresenter {
    
    var itemsCount: Int {
        return OrderDetailsTypes.allCases.count
    }
    
    func configureNavigationBarCellItem(_ cell: AppNavigationItemCollectionViewCellProtocol, atIndex index: Int) {
        cell.displayItem(title: OrderDetailsTypes.allCases[index].rawValue.localized())
    }
    
    func didSelectNavigationBarCellItem(atIndex index: Int) {
        orderDetailsType = OrderDetailsTypes.allCases[index]
        if let selectedIndex = OrderDetailsTypes.allCases.firstIndex(where: { $0 == orderDetailsType }) {
            view?.updateAppBarBottomView(atIndex: selectedIndex)
        }
        switch orderDetailsType {
        case .orderDetails:
            router.showOrderDetailsTypeView()
            router.hideOrderUpdatesTypeView()
            Player.shared.stop()
        case .orderUpdates:
            router.showOrderUpdatesTypeView(orderComments: orderComments)
            router.hideOrderDetailsTypeView()
        }
    }
}
