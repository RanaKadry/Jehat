//
//  HomeRouter.swift
//  Jihat
//
//  Created Peter Bassem on 21/09/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit
import SideMenu

// MARK: Home Router -

class HomeRouter: BaseRouter, HomeRouterProtocol {
    
    private var sidemenuViewController: UIViewController!
    
    static func createModule() -> UIViewController {
        let view =  HomeViewController()

        let interactor = HomeInteractor(
            useCase: HomeUseCase(
                userRepository: UserRepositoryImp(),
                orderRepository: OrderRepositoryImp(),
                meetingRepository: MeetingRepositoryImp(),
                appointmentRepository: AppointmentRepoistoryImp(),
                languageRepository: LanguageRepositoryImp()
            )
        )
        let router = HomeRouter()
        let presenter = HomePresenter(view: view, interactor: interactor, router: router)
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        return view
    }

    func showSidemenuViewController(user: UserDataResponse, profileButtonPressed: @escaping ActionCompletion, didSelectMenuItem: @escaping SideMenuSelectionItem, delegate: SideMenuNavigationViewControllerDelegate?) {
        sidemenuViewController = SideMenuRouter.createModule(user: user, profileButtonPressed: profileButtonPressed, didSelectMenuItem: didSelectMenuItem)
        let sideMenuNavigationController = SideMenuNavigationViewController(rootViewController: sidemenuViewController)
        sideMenuNavigationController.sideMenuNavigationDelegate = delegate
        viewController?.present(sideMenuNavigationController, animated: true)
    }
    
    func hideSidemenuViewController() {
        sidemenuViewController.dismiss(animated: true)
    }
    
    func navigateToProfileViewController(updateProfileCompletion: UpdateProfileCompletion) {
        let profileViewController = ProfileRouter.createModule(updateProfileCompletion: updateProfileCompletion)
        viewController?.navigationController?.pushViewController(profileViewController, animated: true)
    }
    
    func presentFilterOrderViewController(orderFilterItems: [TicketFilterItemsResponse], filterOrderCompletion: FilterOrderCompletion) {
        let filterOrderViewController = FilterOrderRouter.createModule(orderFilterItems: orderFilterItems, filterOrderCompletion: filterOrderCompletion)
        filterOrderViewController.modalPresentationStyle = .overFullScreen
        viewController?.present(filterOrderViewController, animated: true)
    }
    
    func presenterFilterMeetingViewController(meetingFilterItems: [MeetingFilterItemsResponse], filterMeetingCompletion: FilterMeetingCompletion) {
        let filterMeetingViewController = FilterMeetingRouter.createModule(meetingFilterItems: meetingFilterItems, filterMeetingCompletion: filterMeetingCompletion)
        filterMeetingViewController.modalPresentationStyle = .overFullScreen
        viewController?.present(filterMeetingViewController, animated: true)
    }
    
    func presentFilterAppointmentViewController(filterAppointmentCompletion: FilterAppointmentCompletion) {
        let filterAppointmentViewController = FilterAppointmentRouter.createModule(filterAppointmentCompletion: filterAppointmentCompletion)
        filterAppointmentViewController.modalPresentationStyle = .overFullScreen
        viewController?.present(filterAppointmentViewController, animated: true)
    }
    
    func navigateToOrderDetailsViewController(withOrderId orderId: String?) {
        let orderDetailsViewController = OrderDetailsRouter.createModule(withOrderId: orderId)
        viewController?.navigationController?.pushViewController(orderDetailsViewController, animated: true)
    }
    
    func navigateToMeetingDetailsViewController(withMeetingId meetingId: String?) {
        let userMeetingDetailsViewController = UserMeetingDetailsRouter.createModule(meetingId: meetingId)
        viewController?.navigationController?.pushViewController(userMeetingDetailsViewController, animated: true)
    }
    
    func navigateToAppointmentDetailsViewController(withAppointmentId appointmentId: String?) {
        let appointmentDetailsViewController = AppointmentDetailsRouter.createModule(appointmentId: appointmentId)
        viewController?.navigationController?.pushViewController(appointmentDetailsViewController, animated: true)
    }

    func navigateToNewOrderViewController(addOrderCompletion: @escaping ActionCompletion) {
        let newOrderViewController = NewOrderRouter.createModule(addOrderCompletion: addOrderCompletion)
        viewController?.navigationController?.pushViewController(newOrderViewController, animated: true)
    }
    
    func navigateToNewAppointmentViewController(addAppointmentCompletion: @escaping ActionCompletion) {
        let newAppointmentViewController = NewAppointmentRouter.createModule(addAppointmentCompletion: addAppointmentCompletion)
        viewController?.navigationController?.pushViewController(newAppointmentViewController, animated: true)
    }
    
    func navigateToDelegatesListViewController() {
        let delegatesListViewController = DelegatesListRouter.createModule()
        viewController?.navigationController?.pushViewController(delegatesListViewController, animated: true)
    }
    
    
    func navigateToDocumentsViewController() {
        let documentsViewController = DocumentsRouter.createModule()
        viewController?.navigationController?.pushViewController(documentsViewController, animated: true)
    }
    
    func navigateToLoginViewController() {
        let loginViewController = UINavigationController(rootViewController: LoginRouter.createModule())
        keyWindow?.rootViewController = loginViewController
    }
}
