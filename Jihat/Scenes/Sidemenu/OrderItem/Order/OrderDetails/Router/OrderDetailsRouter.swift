//
//  OrderDetailsRouter.swift
//  Jihat
//
//  Created Peter Bassem on 29/09/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

// MARK: OrderDetails Router -

class OrderDetailsRouter: BaseRouter, OrderDetailsRouterProtocol {
    
    private var orderDetailsTypeViewController: UIViewController?
    private var orderUpdatesTypeViewController: UIViewController?
    
    static func createModule(withOrderId orderId: String?) -> UIViewController {
        let view =  OrderDetailsViewController()

        let interactor = OrderDetailsInteractor(
            useCase: OrderDetailsUseCase(
                userRepository: UserRepositoryImp(),
                orderRepository: OrderRepositoryImp()
            )
        )
        let router = OrderDetailsRouter()
        let presenter = OrderDetailsPresenter(view: view, interactor: interactor, router: router, orderId: orderId)
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        return view
    }
    
    func addOrderDetailsTypeViewController(order: UserOrdersResponse) {
        orderDetailsTypeViewController = OrderDetailsTypeRouter.createModule(order: order)
        if let orderDetailsViewcontroller = viewController as? OrderDetailsViewController {
            orderDetailsViewcontroller.addChild(orderDetailsTypeViewController ?? UIViewController())
            orderDetailsViewcontroller.add(orderDetailsTypeViewController ?? UIViewController())
            orderDetailsTypeViewController?.view.translatesAutoresizingMaskIntoConstraints = false
            orderDetailsViewcontroller._childrenViewControllerContainerView.addSubview(orderDetailsTypeViewController?.view ?? UIView())
            orderDetailsTypeViewController?.view.fillSuperview()
            orderDetailsTypeViewController?.didMove(toParent: orderDetailsViewcontroller)
        }
    }
    
    func removeOrderDetailsTypeViewController() {
        orderDetailsTypeViewController?.remove()
    }
    
    func addOrderUpdatesTypeViewController(orderComments: [UserOrderCommentsResponse], addTextAction: @escaping ActionCompletion, addVoiceNoteAction: @escaping ActionCompletion, addAttachmentAction: @escaping ActionCompletion) {
        orderUpdatesTypeViewController = OrderUpdatesTypeRouter.createModule(orderComments: orderComments, addTextAction: addTextAction, addVoiceNoteAction: addVoiceNoteAction, addAttachmentAction: addAttachmentAction)
        if let orderDetailsViewcontroller = viewController as? OrderDetailsViewController {
            orderDetailsViewcontroller.addChild(orderUpdatesTypeViewController ?? UIViewController())
            orderDetailsViewcontroller.add(orderUpdatesTypeViewController ?? UIViewController())
            orderUpdatesTypeViewController?.view.translatesAutoresizingMaskIntoConstraints = false
            orderDetailsViewcontroller._childrenViewControllerContainerView.addSubview(orderUpdatesTypeViewController?.view ?? UIView())
            orderUpdatesTypeViewController?.view.fillSuperview()
            orderUpdatesTypeViewController?.didMove(toParent: orderDetailsViewcontroller)
        }
    }
    
    func removeOrderUpdatesTypeViewController() {
        orderUpdatesTypeViewController?.remove()
    }
    
    func showOrderDetailsTypeView() {
        orderDetailsTypeViewController?.view.isHidden = false
    }
    
    func hideOrderDetailsTypeView() {
        orderDetailsTypeViewController?.view.isHidden = true
    }
    
    func showOrderUpdatesTypeView(orderComments: [UserOrderCommentsResponse]?) {
        orderUpdatesTypeViewController?.view.isHidden = false
        if let orderUpdatesTypeViewController = orderUpdatesTypeViewController as? OrderUpdatesTypeViewController {
            orderUpdatesTypeViewController.presenter.updateOrderComments(orderComments: orderComments)
            orderUpdatesTypeViewController.presenter.showOrderUpdates()
        }
    }
    
    func hideOrderUpdatesTypeView() {
        orderUpdatesTypeViewController?.view.isHidden = true
    }
    
    func presentAddTextViewController(orderId: String?, addTexTCompletion: @escaping ActionCompletion) {
        let addTextViewController = AddTextRouter.createModule(orderId: orderId, addTexTCompletion: addTexTCompletion)
        addTextViewController.modalPresentationStyle = .overCurrentContext
        viewController?.present(addTextViewController, animated: true)
    }
    
    func presentAddVoiceNoteViewController(orderId: String?, addVoiceNoteCompletion: @escaping ActionCompletion) {
        let addVoiceNoteViewController = AddVoiceNoteRouter.createModule(orderId: orderId, addVoiceNoteCompletion: addVoiceNoteCompletion)
        addVoiceNoteViewController.modalPresentationStyle = .overCurrentContext
        viewController?.present(addVoiceNoteViewController, animated: true)
    }
    
    func presentAddAttachmentViewController(orderId: String?, addAttachmentsCompletion: @escaping ActionCompletion) {
        let addAttachmentViewController = AddAttachmentsRouter.createModule(orderId: orderId, addAttachmentsCompletion: addAttachmentsCompletion)
        addAttachmentViewController.modalPresentationStyle = .overCurrentContext
        viewController?.present(addAttachmentViewController, animated: true)
    }
}
