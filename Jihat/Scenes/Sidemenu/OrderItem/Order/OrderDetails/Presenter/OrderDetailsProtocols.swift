//
//  OrderDetailsProtocols.swift
//  Jihat
//
//  Created Peter Bassem on 29/09/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

// MARK: OrderDetails Protocols

protocol OrderDetailsViewProtocol: BaseViewProtocol {
    var presenter: OrderDetailsPresenterProtocol! { get set }
    
    func updateAppBarBottomView(atIndex index: Int)
    func refreshAppBarCollectionView()
    func refreshView()
}

protocol OrderDetailsPresenterProtocol: BasePresenterProtocol {
    var view: OrderDetailsViewProtocol? { get set }
    
    func viewDidLoad()

    var itemsCount: Int { get }
    func configureNavigationBarCellItem(_ cell: AppNavigationItemCollectionViewCellProtocol, atIndex index: Int)
    func didSelectNavigationBarCellItem(atIndex index: Int)
    
    func performBack()
}

protocol OrderDetailsRouterProtocol: BaseRouterProtocol {
    func addOrderDetailsTypeViewController(order: UserOrdersResponse)
    func removeOrderDetailsTypeViewController()
    func addOrderUpdatesTypeViewController(orderComments: [UserOrderCommentsResponse], addTextAction: @escaping ActionCompletion, addVoiceNoteAction: @escaping ActionCompletion, addAttachmentAction: @escaping ActionCompletion)
    func removeOrderUpdatesTypeViewController()
    func showOrderDetailsTypeView()
    func hideOrderDetailsTypeView()
    func showOrderUpdatesTypeView(orderComments: [UserOrderCommentsResponse]?)
    func hideOrderUpdatesTypeView()
    func presentAddTextViewController(orderId: String?, addTexTCompletion: @escaping ActionCompletion)
    func presentAddVoiceNoteViewController(orderId: String?, addVoiceNoteCompletion: @escaping ActionCompletion)
    func presentAddAttachmentViewController(orderId: String?, addAttachmentsCompletion: @escaping ActionCompletion)
}

protocol OrderDetailsInteractorInputProtocol: BaseInteractorInputProtocol {
    var presenter: OrderDetailsInteractorOutputProtocol? { get set }
    
    var userToken: String? { get }
    func getOrderDetailsData(userOrderDetailsRequest: UserOrderDetailsRequest)
    func getOrderDetailsComments(userORderDetailsCommentsRequest: UserOrderDetailsRequest)
}

protocol OrderDetailsInteractorOutputProtocol: BaseInteractorOutputProtocol {
    func fetchingOrderDetailsWithSuccess(order: UserOrdersResponse)
    func fetchingOrderDetailsCommentsWithSuccess(orderComments: [UserOrderCommentsResponse])
    func fetchingUpdatedOrderDetailsCommentsWithSuccess(orderComments: [UserOrderCommentsResponse])
    func fetchingWithError(error: String)
    func finishFetchingOrderDetailsData()
}
