//
//  HomeProtocols.swift
//  Jihat
//
//  Created Peter Bassem on 21/09/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation
import UIKit

// MARK: Home Protocols

protocol HomeViewProtocol: BaseViewProtocol {
    var presenter: HomePresenterProtocol! { get set }
    
    func showBlurView()
    func hideBlurView()
    
    func setSearchActionButton(image: UIImage)
    func updateUserAction(type: UserHomeActions)
    func refreshCollectionView()
    func showEmptyOrders()
    func showEmptyMeetings()
    func showEmptyCalendars()
    func refreshAppBarCollectionView()
    func updateAppBarBottomView(atIndex index: Int)
    
    func updateAddNewOrderButton(image: UIImage, title: String)
    func hideNewActionButton()
    func showNewActionButton()
    func updateAddNewAppointmentButton(image: UIImage, title: String)
    
    func showEmptySearchResults()
}

protocol HomePresenterProtocol: BasePresenterProtocol {
    var view: HomeViewProtocol? { get set }
    
    func viewDidLoad()

    var itemsCount: Int { get }
    func configureNavigationBarCellItem(_ cell: AppNavigationItemWithImageCollectionViewCellProtocol, atIndex index: Int)
    func didSelectNavigationBarCellItem(atIndex index: Int)
    
    var userItemsCount: Int { get }
    func configureMyOrderItemCell(_ cell: MyOrderItemCollectionViewCellProtocol, atIndex index: Int)
    func configureMyMeetingItemCell(_ cell: MyMeetingItemCollectionViewCellProtocol, atIndex index: Int)
    func configureMyCalendarItemCell(_ cell: MyCalendarItemCollectionViewCellProtocol, atIndex index: Int)
    func didSelectItem(atIndex index: Int)
    
    func performPrefetchItems(atIndexPaths indexPaths: [IndexPath])
    
    func updateIsSearching(_ isSearching: Bool)
    func searchItems(withSearchText searchText: String)
    
    func performOpenSidemenu()
    func performContactUs()
    func performSearchFilterActionButton()
    func performNewActionButton()
}

protocol HomeRouterProtocol: BaseRouterProtocol {
    func showSidemenuViewController(user: UserDataResponse, profileButtonPressed: @escaping ActionCompletion, didSelectMenuItem: @escaping SideMenuSelectionItem, delegate: SideMenuNavigationViewControllerDelegate?)
    func hideSidemenuViewController()
    func navigateToProfileViewController(updateProfileCompletion: UpdateProfileCompletion)
    func presentFilterOrderViewController(orderFilterItems: [TicketFilterItemsResponse], filterOrderCompletion: FilterOrderCompletion)
    func presenterFilterMeetingViewController(meetingFilterItems: [MeetingFilterItemsResponse], filterMeetingCompletion: FilterMeetingCompletion)
    func presentFilterAppointmentViewController(filterAppointmentCompletion: FilterAppointmentCompletion)
    func navigateToOrderDetailsViewController(withOrderId orderId: String?)
    func navigateToMeetingDetailsViewController(withMeetingId meetingId: String?)
    func navigateToAppointmentDetailsViewController(withAppointmentId appointmentId: String?)

    func navigateToNewOrderViewController(addOrderCompletion: @escaping ActionCompletion)
    func navigateToNewAppointmentViewController(addAppointmentCompletion: @escaping ActionCompletion)
    func navigateToDelegatesListViewController()
    func navigateToDocumentsViewController()
    func navigateToLoginViewController()
}

protocol HomeInteractorInputProtocol: BaseInteractorInputProtocol {
    var presenter: HomeInteractorOutputProtocol? { get set }
 
    var userToken: String? { get }
    func getHomeData(homeRequest: BaseRequest, userOrdersRequest: UserOrdersRequest, meetingsRequest: UserMeetingsRequest, appointmentsRequest: UserAppointmentsRequest)
    func getOrderFilterItems()
    func updateUserOrders(userOrdersRequest: UserOrdersRequest, isFiltering: Bool)
    func getMeetingFilterItems()
    func updateUserMeetings(userMeetingsRequest: UserMeetingsRequest, isFiltering: Bool)
    func updateUserAppointments(appointmentsRequest: UserAppointmentsRequest, isFiltering: Bool)
    func logoutUser(_ logoutRequest: BaseRequest)
    var getCurrentLanguage: String { get }
    func updateLanguage(_ newLanguage: String)
    func clearLocalData()
}

protocol HomeInteractorOutputProtocol: BaseInteractorOutputProtocol {
    func fetchingLogoutWithSuccess()
    func fetchingHomeItemsWithSuccess(user: UserDataResponse)
    func fetchingGuestHomeItemsWithSuccess()
    func fetchingUserOrdersWithSuccess(orders: [UserOrdersResponse])
    func fetchingEmptyUserOrdersWithSuccess()
    func fetchingUserMeetingsWithSuccess(meetings: [UserMeetingsResponse])
    func fetchingEmptyUserMeetingsWithSuccess()
    func fetchingUserAppointmentsWithSuccess(appointments: [UserAppointmentsResponse])
    func fetchingEmptyUserAppointmentsWithSuccess()
    func showEmptyView()
    func fetchingOrderFilterItems(orderFilterItems: [TicketFilterItemsResponse])
    func fetchingMeetingFilterItems(meetingFilterItems: [MeetingFilterItemsResponse])
    func fetchingWithError(error: String)
}
