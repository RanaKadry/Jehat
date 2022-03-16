//
//  HomePresenter.swift
//  Jihat
//
//  Created Peter Bassem on 21/09/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

enum OrderStatus {
    case defaultAction, filter, cancel
}

enum MeetingStatus {
    case defaultAction, filter, cancel
}

enum AppointmentStatus {
    case defaultAction, filter, cancel
}

// MARK: Home Presenter -

class HomePresenter: BasePresenter {

    weak var view: HomeViewProtocol?
    private let interactor: HomeInteractorInputProtocol
    private let router: HomeRouterProtocol
    
    private var user: UserDataResponse!
    private var sideMenuDelegate: SideMenuDelegate!
    private var userSelectedAction: UserHomeActions = .orders
    
    private var selectedMenuItemIndex = 0
    private var selectedMenuItemIndexPath = IndexPath(item: 0, section: 0)
    
    private var currentOrderPage = 1
    private var currentFilterOrderPage = 1
    private var orders: [UserOrdersResponse] = []
    private var ordersSearchResults: [UserOrdersResponse] = []
    private var filteredOrders: [UserOrdersResponse] = []
    private var filteredOrdersSearchResults: [UserOrdersResponse] = []
    private var isFetchingOrders = false
    private var isSearchingOrders = false
    private var userOrdersStatus: OrderStatus = .defaultAction
    private var filteredOrderStatus: TicketFilterItemsResponse?
    
    private var currentMeetingPage = 1
    private var currentFilterMeetingPage = 1
    private var meetings: [UserMeetingsResponse] = []
    private var meetingsSearchResults: [UserMeetingsResponse] = []
    private var filteredMeetings: [UserMeetingsResponse] = []
    private var filteredMeetingsSearchResults: [UserMeetingsResponse] = []
    private var isFetchingMeetings = false
    private var isSearchingMeetings = false
    private var userMeetingStatus: MeetingStatus = .defaultAction
    private var filteredMeetingStatus: MeetingFilterItemsResponse?
    
    private var currentAppointmentPage = 1
    private var currentFilterAppointmentPage = 1
    private var appointments: [UserAppointmentsResponse] = []
    private var appointmentsSearchResults: [UserAppointmentsResponse] = []
    private var filteredAppointments: [UserAppointmentsResponse] = []
    private var filteredAppointmentsSearchResults: [UserAppointmentsResponse] = []
    private var isFetchingAppointments = false
    private var isSearchingAppointments = false
    private var userAppointmentsStatus: AppointmentStatus = .defaultAction
    private var filteredMeetingStartDate: String?
    private var filteredMeetingEndDate: String?
    private var filteredAppointmentStartDate: String?
    private var filteredAppointmentEndDate: String?
    
    init(view: HomeViewProtocol, interactor: HomeInteractorInputProtocol, router: HomeRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    private func setSearchActionButtonImage() {
        switch userSelectedAction {
        case .orders:
            switch userOrdersStatus {
            case .defaultAction:
                view?.setSearchActionButton(image: DesignSystem.Icon.filter.image.withRenderingMode(.alwaysOriginal))
            case .filter:
                view?.setSearchActionButton(image: DesignSystem.Icon.close.image.withRenderingMode(.alwaysOriginal))
            case .cancel:
                view?.setSearchActionButton(image: DesignSystem.Icon.filter.image.withRenderingMode(.alwaysOriginal))
            }
        case .meetings:
            switch userMeetingStatus {
            case .defaultAction:
                view?.setSearchActionButton(image: DesignSystem.Icon.filter.image.withRenderingMode(.alwaysOriginal))
            case .filter:
                view?.setSearchActionButton(image: DesignSystem.Icon.close.image.withRenderingMode(.alwaysOriginal))
            case .cancel:
                view?.setSearchActionButton(image: DesignSystem.Icon.filter.image.withRenderingMode(.alwaysOriginal))
            }
        case .calendars:
            switch userAppointmentsStatus {
            case .defaultAction:
                view?.setSearchActionButton(image: DesignSystem.Icon.calendar.image.withRenderingMode(.alwaysOriginal))
            case .filter:
                view?.setSearchActionButton(image: DesignSystem.Icon.close.image.withRenderingMode(.alwaysOriginal))
            case .cancel:
                view?.setSearchActionButton(image: DesignSystem.Icon.calendar.image.withRenderingMode(.alwaysOriginal))
            }
        }
    }
    
    private func updateItemSelection() {
        setSearchActionButtonImage()
        view?.updateUserAction(type: userSelectedAction)
        switch userSelectedAction {
        case .orders:
            (userOrdersStatus == .filter ? (filteredOrders.isEmpty) : (orders.isEmpty)) ? view?.showEmptyOrders() : view?.refreshCollectionView()
        case .meetings:
            (userMeetingStatus == .filter ? (filteredMeetings.isEmpty) : (meetings.isEmpty)) ? view?.showEmptyMeetings() : view?.refreshCollectionView()
        case .calendars:
            (userAppointmentsStatus == .filter ? (filteredAppointments.isEmpty) : (appointments.isEmpty)) ? view?.showEmptyCalendars() : view?.refreshCollectionView()
        }
        if let selectedIndex = UserHomeActions.allCases.firstIndex(where: { $0 == userSelectedAction }) {
            view?.updateAppBarBottomView(atIndex: selectedIndex)
        }
        switch userSelectedAction {
        case .orders:
            view?.showNewActionButton()
            view?.updateAddNewOrderButton(image: DesignSystem.Icon.addOrder.image, title: "add_new_order".localized())
        case .meetings:
            view?.hideNewActionButton()
        case .calendars:
            view?.showNewActionButton()
            view?.updateAddNewOrderButton(image: DesignSystem.Icon.itemStatus.image, title: "add_new_appointment".localized())
        }
    }
    
    private func hideHomeLoading() {
        view?.hideLoading()
        view?.hideBlurView()
    }
    
    private func filterOrdersActionButton(orderFilterItems: [TicketFilterItemsResponse]) {
        switch userOrdersStatus {
        case .filter:
            userOrdersStatus = .defaultAction
            setSearchActionButtonImage()
            currentFilterOrderPage = 1
            filteredOrderStatus = nil
            let userOrdersRequest = UserOrdersRequest(userToken: interactor.userToken, pageNumber: currentOrderPage.toString(), filter: "")
            interactor.updateUserOrders(userOrdersRequest: userOrdersRequest, isFiltering: true)
        case .defaultAction:
            router.presentFilterOrderViewController(orderFilterItems: orderFilterItems) { [weak self] filterOrderItem in
                self?.currentOrderPage = 1
                self?.userOrdersStatus = .filter
                self?.setSearchActionButtonImage()
                self?.filteredOrderStatus = filterOrderItem
                let userOrdersRequest = UserOrdersRequest(userToken: self?.interactor.userToken, pageNumber: self?.currentFilterOrderPage.toString(), filter: filterOrderItem.id)
                self?.interactor.updateUserOrders(userOrdersRequest: userOrdersRequest, isFiltering: true)
            }
        case .cancel: break
        }
    }
    
    private func filterMeetingsActionButton(_ meetingFilterItems: [MeetingFilterItemsResponse]) {
        switch userMeetingStatus {
        case .filter:
            userMeetingStatus = .defaultAction
            setSearchActionButtonImage()
            currentFilterMeetingPage = 1
            filteredMeetingStatus = nil
            let userMeetingsRequest = UserMeetingsRequest(userToken: interactor.userToken, pageNumber: currentMeetingPage.toString(), filter: "-1")
            interactor.updateUserMeetings(userMeetingsRequest: userMeetingsRequest, isFiltering: true)
        case .defaultAction:
            router.presenterFilterMeetingViewController(meetingFilterItems: meetingFilterItems) { [weak self] filterMeetingItem in
                self?.currentMeetingPage = 1
                self?.userMeetingStatus = .filter
                self?.setSearchActionButtonImage()
                self?.filteredMeetingStatus = filterMeetingItem
                let userMeetingsRequest = UserMeetingsRequest(userToken: self?.interactor.userToken, pageNumber: self?.currentFilterMeetingPage.toString(), filter: filterMeetingItem.id)
                self?.interactor.updateUserMeetings(userMeetingsRequest: userMeetingsRequest, isFiltering: true)
            }
        case .cancel: break
        }
    }
    
    private func filterAppointmentsActionButton() {
        switch userAppointmentsStatus {
        case .filter:
            userAppointmentsStatus = .defaultAction
            setSearchActionButtonImage()
            currentFilterAppointmentPage = 1
            filteredAppointmentStartDate = nil
            filteredAppointmentEndDate = nil
            let userAppointmentsRequest = UserAppointmentsRequest(userToken: interactor.userToken, pageNumber: currentAppointmentPage.toString(), dateFrom: "", dateTo: "")
            interactor.updateUserAppointments(appointmentsRequest: userAppointmentsRequest, isFiltering: true)
        case .defaultAction:
            router.presentFilterAppointmentViewController { [weak self] startDate, endDate in
                self?.currentAppointmentPage = 1
                self?.userAppointmentsStatus = .filter
                self?.setSearchActionButtonImage()
                self?.filteredAppointmentStartDate = startDate
                self?.filteredAppointmentEndDate = endDate
                let userAppointmentsRequest = UserAppointmentsRequest(userToken: self?.interactor.userToken, pageNumber: self?.currentFilterAppointmentPage.toString(), dateFrom: startDate, dateTo: endDate)
                self?.interactor.updateUserAppointments(appointmentsRequest: userAppointmentsRequest, isFiltering: true)
            }
        case .cancel: break
        }
    }
    
    func showEmptyViews() {
        switch userSelectedAction {
        case .orders:
            view?.showEmptyOrders()
        case .meetings:
            view?.showEmptyMeetings()
        case .calendars:
            view?.showEmptyCalendars()
        }
    }
}

// MARK: - HomePresenterProtocol
extension HomePresenter: HomePresenterProtocol {
    
    func viewDidLoad() {
        setSearchActionButtonImage()
        view?.showLoading()
        interactor.getHomeData(
            homeRequest: BaseRequest(userToken: interactor.userToken ?? ""),
            userOrdersRequest: UserOrdersRequest(userToken: interactor.userToken ?? "", pageNumber: currentOrderPage.toString(), filter: ""),
            meetingsRequest: UserMeetingsRequest(userToken: interactor.userToken ?? "", pageNumber: currentMeetingPage.toString(), filter: "-1"),
            appointmentsRequest: UserAppointmentsRequest(userToken: interactor.userToken ?? "", pageNumber: currentAppointmentPage.toString(), dateFrom: "", dateTo: ""))
    }
    
    func performPrefetchItems(atIndexPaths indexPaths: [IndexPath]) {
        switch userSelectedAction {
        case .orders:
            for indexPath in indexPaths {
                if (userOrdersStatus == .filter ? (indexPath.item >= filteredOrders.count - 3) : (indexPath.item >= orders.count - 3)) && !isFetchingOrders {
                    let userOrdersRequest = UserOrdersRequest(userToken: interactor.userToken, pageNumber: userOrdersStatus == .filter ? currentFilterOrderPage.toString() : currentOrderPage.toString(), filter: userOrdersStatus == .filter ? filteredOrderStatus?.id : "")
                    interactor.updateUserOrders(userOrdersRequest: userOrdersRequest, isFiltering: false)
                    isFetchingOrders = true
                    break
                }
            }
        case .meetings:
            for indexPath in indexPaths {
                if (userMeetingStatus == .filter ? (indexPath.item >= filteredMeetings.count - 3) : (indexPath.item >= meetings.count - 3)) && !isFetchingMeetings {
                    let userMeetingsRequest = UserMeetingsRequest(userToken: interactor.userToken, pageNumber: userMeetingStatus == .filter ? currentFilterMeetingPage.toString() : currentMeetingPage.toString(), filter: userMeetingStatus == .filter ? filteredMeetingStatus?.id : "-1")
                    print("userMeetingsRequest:", userMeetingsRequest)
                    interactor.updateUserMeetings(userMeetingsRequest: userMeetingsRequest, isFiltering: false)
                    isFetchingMeetings = true
                    break
                }
            }
        case .calendars:
            for indexPath in indexPaths {
                if (userAppointmentsStatus == .filter ? (indexPath.item >= filteredAppointments.count - 3) : (indexPath.item >= appointments.count - 3)) && !isFetchingAppointments {
                    let userAppointmentsRequest = UserAppointmentsRequest(userToken: interactor.userToken, pageNumber: userAppointmentsStatus == .filter ? currentFilterAppointmentPage.toString() : currentAppointmentPage.toString(), dateFrom: userAppointmentsStatus == .filter ? filteredAppointmentStartDate : "", dateTo: userAppointmentsStatus == .filter ? filteredAppointmentEndDate : "")
                    interactor.updateUserAppointments(appointmentsRequest: userAppointmentsRequest, isFiltering: false)
                    isFetchingAppointments = true
                    break
                }
            }
        }
    }
}

// MARK: - API
extension HomePresenter: HomeInteractorOutputProtocol {
    
    func fetchingHomeItemsWithSuccess(user: UserDataResponse) {
        hideHomeLoading()
        self.user = user
        view?.refreshAppBarCollectionView()
    }
    
    func fetchingGuestHomeItemsWithSuccess() {
        self.user = UserDataResponse(id: nil, englishName: "Guest", arabicName: "زائر", phone: nil, email: nil, identificiationNumber: nil, arabicAddress: nil, englishAddress: nil, fax: nil, gender: nil, genderId: nil, nationality: nil, country: nil, countryId: nil)
        view?.refreshAppBarCollectionView()
    }
    
    func fetchingUserOrdersWithSuccess(orders: [UserOrdersResponse]) {
        hideHomeLoading()
        switch userOrdersStatus {
        case .defaultAction, .cancel:
            self.orders.append(contentsOf: orders)
            currentOrderPage += 1
        case .filter:
            self.filteredOrders.append(contentsOf: orders)
            currentFilterOrderPage += 1
        }
        view?.refreshCollectionView()
        isFetchingOrders = false
    }
    
    func fetchingEmptyUserOrdersWithSuccess() {
        hideHomeLoading()
        isFetchingOrders = false
        orders.removeAll()
        filteredOrders.removeAll()
        showEmptyViews()
    }
    
    func fetchingUserMeetingsWithSuccess(meetings: [UserMeetingsResponse]) {
        hideHomeLoading()
        switch userMeetingStatus {
        case .defaultAction, .cancel:
            self.meetings.append(contentsOf: meetings)
            currentMeetingPage += 1
        case .filter:
            self.filteredMeetings.append(contentsOf: meetings)
            currentFilterMeetingPage += 1
        }
        view?.refreshCollectionView()
        isFetchingMeetings = false
    }
    
    func fetchingEmptyUserMeetingsWithSuccess() {
        hideHomeLoading()
        isFetchingMeetings = false
        meetings.removeAll()
        filteredMeetings.removeAll()
        showEmptyViews()
    }
    
    func fetchingUserAppointmentsWithSuccess(appointments: [UserAppointmentsResponse]) {
        hideHomeLoading()
        switch userAppointmentsStatus {
        case .defaultAction, .cancel:
            self.appointments.append(contentsOf: appointments)
            currentAppointmentPage += 1
        case .filter:
            self.filteredAppointments.append(contentsOf: appointments)
            currentFilterAppointmentPage += 1
        }
        view?.refreshCollectionView()
        isFetchingAppointments = false
    }
    
    func fetchingEmptyUserAppointmentsWithSuccess() {
        hideHomeLoading()
        isFetchingAppointments = false
        appointments.removeAll()
        filteredAppointments.removeAll()
        showEmptyViews()
    }
    
    func showEmptyView() {
        hideHomeLoading()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.015) { [weak self] in
            switch self?.userSelectedAction ?? .orders {
            case .orders: self?.view?.showEmptyOrders()
            case .meetings: self?.view?.showEmptyMeetings()
            case .calendars: self?.view?.showEmptyCalendars()
            }
        }
    }
    
    func fetchingLogoutWithSuccess() {
        let lastCurrentLanguage = interactor.getCurrentLanguage
        interactor.clearLocalData()
        interactor.updateLanguage(lastCurrentLanguage)
        router.navigateToLoginViewController()
    }
    
    func fetchingOrderFilterItems(orderFilterItems: [TicketFilterItemsResponse]) {
        filterOrdersActionButton(orderFilterItems: orderFilterItems)
    }
    
    func fetchingMeetingFilterItems(meetingFilterItems: [MeetingFilterItemsResponse]) {
        filterMeetingsActionButton(meetingFilterItems)
    }
    
    func fetchingWithError(error: String) {
        hideHomeLoading()
        view?.showBottomMessage(error)
    }
}

// MARK: - Selectors
extension HomePresenter {
    
    func performOpenSidemenu() {
        guard let user = user else {
            router.presentActionControl(title: nil, message: "logout_confirm_message".localized(), actionTitle: "logout".localized().uppercased()) { [weak self] in
                let logoutRequest = BaseRequest(userToken: self?.interactor.userToken)
                self?.interactor.logoutUser(logoutRequest)
            }
            return
        }
        sideMenuDelegate = SideMenuDelegate(showSideMenu: { [weak self] in
            self?.view?.showBlurView()
        }, hideSideMenu: { [weak self] in
            self?.view?.hideBlurView()
        })
        router.showSidemenuViewController(user: user, profileButtonPressed: { [weak self] in
            self?.router.hideSidemenuViewController()
            self?.router.navigateToProfileViewController(updateProfileCompletion: { [weak self] user in
                self?.user = user
            })
        }, didSelectMenuItem: { [weak self] selectedSideMenu in
            self?.router.hideSidemenuViewController()
            switch selectedSideMenu {
            case .addOrder:
                self?.router.navigateToNewOrderViewController { [weak self] in
                    self?.orders.removeAll()
                    self?.ordersSearchResults.removeAll()
                    self?.filteredOrders.removeAll()
                    self?.filteredOrdersSearchResults.removeAll()
                    self?.currentOrderPage = 1
                    self?.currentFilterOrderPage = 1
                    self?.view?.showLoading()
                    let userOrdersRequest = UserOrdersRequest(userToken: self?.interactor.userToken, pageNumber: self?.userOrdersStatus == .filter ? self?.currentFilterOrderPage.toString() : self?.currentOrderPage.toString(), filter: self?.userOrdersStatus == .filter ? self?.filteredOrderStatus?.id : "")
                    self?.interactor.updateUserOrders(userOrdersRequest: userOrdersRequest, isFiltering: false)
                }
            case .myOrders:
                self?.userSelectedAction = .orders
                if self?.orders.isEmpty == true {
                    self?.view?.showEmptyOrders()
                } else {
                    self?.view?.refreshCollectionView()
                }
                self?.updateItemSelection()
            case .myMeetings:
                self?.userSelectedAction = .meetings
                if self?.meetings.isEmpty == true {
                    self?.view?.showEmptyMeetings()
                } else {
                    self?.view?.refreshCollectionView()
                }
                self?.updateItemSelection()
            case .myCalendar:
                self?.userSelectedAction = .calendars
                if self?.appointments.isEmpty == true {
                    self?.view?.showEmptyCalendars()
                } else {
                    self?.view?.refreshCollectionView()
                }
                self?.updateItemSelection()
            case .listDelegates:
                self?.router.navigateToDelegatesListViewController()
            case .documents:
                self?.router.navigateToDocumentsViewController()
            case .contactUs:
                self?.startWhatpsappChat(withNumber: GlobalConstants.contactUsPhone.rawValue) { [weak self] error in
                    self?.view?.showBottomMessage(error)
                }
            case .logout:
                self?.router.presentActionControl(title: "logout_confirm".localized(), message: nil, firstActionTitle: "yes".localized(), firstAction: {
                    let logoutRequest = BaseRequest(userToken: self?.interactor.userToken)
                    self?.interactor.logoutUser(logoutRequest)
                }, secondActionTitle: "no".localized()) { [weak self] in
                    self?.router.dismissActionControl()
                }
            }
        }, delegate: sideMenuDelegate)
    }
    
    func performContactUs() {
        startWhatpsappChat(withNumber: GlobalConstants.contactUsPhone.rawValue) { [weak self] error in
            self?.view?.showBottomMessage(error)
        }
    }
    
    func performSearchFilterActionButton() {
        guard user != nil else {
            router.presentActionControl(title: nil, message: "logout_confirm_message".localized(), actionTitle: "logout".localized().uppercased()) { [weak self] in
                let logoutRequest = BaseRequest(userToken: self?.interactor.userToken)
                self?.interactor.logoutUser(logoutRequest)
            }
            return
        }
        switch userSelectedAction {
        case .orders:
            interactor.getOrderFilterItems()
        case .meetings:
            interactor.getMeetingFilterItems()
        case .calendars:
            filterAppointmentsActionButton()
        }
    }
    
    func performNewActionButton() {
        guard user != nil else {
            router.presentActionControl(title: nil, message: "logout_confirm_message".localized(), actionTitle: "logout".localized().uppercased()) { [weak self] in
                let logoutRequest = BaseRequest(userToken: self?.interactor.userToken)
                self?.interactor.logoutUser(logoutRequest)
            }
            return
        }
        switch userSelectedAction {
        case .orders:
            router.navigateToNewOrderViewController { [weak self] in
                self?.orders.removeAll()
                self?.ordersSearchResults.removeAll()
                self?.filteredOrders.removeAll()
                self?.filteredOrdersSearchResults.removeAll()
                self?.currentOrderPage = 1
                self?.currentFilterOrderPage = 1
                self?.view?.showLoading()
                let userOrdersRequest = UserOrdersRequest(userToken: self?.interactor.userToken, pageNumber: self?.userOrdersStatus == .filter ? self?.currentFilterOrderPage.toString() : self?.currentOrderPage.toString(), filter: self?.userOrdersStatus == .filter ? self?.filteredOrderStatus?.id : "")
                self?.interactor.updateUserOrders(userOrdersRequest: userOrdersRequest, isFiltering: false)
            }
        case .calendars:
            router.navigateToNewAppointmentViewController { [weak self] in
                self?.appointments.removeAll()
                self?.appointmentsSearchResults.removeAll()
                self?.filteredAppointments.removeAll()
                self?.filteredAppointmentsSearchResults.removeAll()
                self?.currentAppointmentPage = 1
                self?.currentFilterAppointmentPage = 1
                self?.view?.showLoading()
                let userAppointmentsRequest = UserAppointmentsRequest(userToken: self?.interactor.userToken, pageNumber: self?.userAppointmentsStatus == .filter ? self?.currentFilterAppointmentPage.toString() : self?.currentAppointmentPage.toString(), dateFrom: "", dateTo: "")
                self?.interactor.updateUserAppointments(appointmentsRequest: userAppointmentsRequest, isFiltering: false)
            }
        default: break
        }
    }
}

// MARK: - AppBar CollectionView Setup
extension HomePresenter {
    
    var itemsCount: Int {
        return UserHomeActions.allCases.count
    }
    
    func configureNavigationBarCellItem(_ cell: AppNavigationItemWithImageCollectionViewCellProtocol, atIndex index: Int) {
        switch UserHomeActions.allCases[index] {
        case .orders:
            cell.setItem(image: DesignSystem.Icon.myOrders.image)
            cell.setItem(title: "my_orders".localized())
        case .meetings:
            cell.setItem(image: DesignSystem.Icon.myMeetings.image)
            cell.setItem(title: "my_meetings".localized())
        case .calendars:
            cell.setItem(image: DesignSystem.Icon.myCalendar.image)
            cell.setItem(title: "my_calendar".localized())
        }
    }
    
    func didSelectNavigationBarCellItem(atIndex index: Int) {
        selectedMenuItemIndex = index
        userSelectedAction = UserHomeActions.allCases[index]
        updateItemSelection()
        
        switch userSelectedAction {
        case .orders:
            (userOrdersStatus == .filter ? (filteredOrders.isEmpty) : (orders.isEmpty)) ? view?.showEmptyOrders() : view?.refreshCollectionView()
        case .meetings:
            (userMeetingStatus == .filter ? (filteredMeetings.isEmpty) : (meetings.isEmpty)) ? view?.showEmptyMeetings() : view?.refreshCollectionView()
        case .calendars:
            (userAppointmentsStatus == .filter ? (filteredAppointments.isEmpty) : (appointments.isEmpty)) ? view?.showEmptyCalendars() : view?.refreshCollectionView()
        }
    }
}

// MARK: - CollectionView Setup
extension HomePresenter {
    
    var userItemsCount: Int {
        switch userSelectedAction {
        case .orders:
            if userOrdersStatus == .filter {
                return isSearchingOrders ? filteredOrdersSearchResults.count : filteredOrders.count
            } else {
                return isSearchingOrders ? ordersSearchResults.count : orders.count
            }
        case .meetings:
            if userMeetingStatus == .filter {
                return isSearchingMeetings ? filteredMeetingsSearchResults.count : filteredMeetings.count
            } else {
                return isSearchingMeetings ? meetingsSearchResults.count : meetings.count
            }
        case .calendars:
            if userAppointmentsStatus == .filter {
                return isSearchingAppointments ? filteredAppointmentsSearchResults.count : filteredAppointments.count
            } else {
                return isSearchingAppointments ? appointmentsSearchResults.count : appointments.count
            }
        }
    }
    
    func configureMyOrderItemCell(_ cell: MyOrderItemCollectionViewCellProtocol, atIndex index: Int) {
        var order: UserOrdersResponse
        if userOrdersStatus == .filter {
            order = isSearchingOrders ? filteredOrdersSearchResults[index] : filteredOrders[index]
        } else {
            order = isSearchingOrders ? ordersSearchResults[index] : orders[index]
        }
        cell.set(orderNumber: LocalizationHelper.isArabic() ? (order.ticketId?.enToArDigits ?? "") : (order.ticketId ?? ""))
        let expectedDateString = String(order.expectedDate?.split(separator: "-").last ?? "")
        cell.set(expectedCompletionDate: Date.localizedDate(date: expectedDateString))
        cell.set(subject: order.subject ?? "")
        cell.set(details: order.detatils ?? "")
    }
    
    func configureMyMeetingItemCell(_ cell: MyMeetingItemCollectionViewCellProtocol, atIndex index: Int) {
        var meeting: UserMeetingsResponse
        if userMeetingStatus == .filter {
            meeting =  isSearchingMeetings ? filteredMeetingsSearchResults[index] : filteredMeetings[index]
        } else {
            meeting = isSearchingMeetings ? meetingsSearchResults[index] : meetings[index]
        }
        let dateString = String(meeting.meetingDate?.split(separator: "-").last ?? "")
        let date = dateString.toDate() ?? Date()
        let dateDay = Date.getDateDay(from: date)
        cell.set(meetingDayDate: String(format: "%@ %@", dateDay, Date.localizedDate(date: dateString)))
        cell.set(meetingTitle: meeting.meetingSubject ?? "")
        cell.set(meetingStatus: meeting.meetingStatus ?? "")
        cell.set(meetingTime: meeting.meetingTime ?? "")
    }
    
    func configureMyCalendarItemCell(_ cell: MyCalendarItemCollectionViewCellProtocol, atIndex index: Int) {
        var appointment: UserAppointmentsResponse
        if userAppointmentsStatus == .filter {
            appointment = isSearchingAppointments ? filteredAppointmentsSearchResults[index] : filteredAppointments[index]
        } else {
            appointment = isSearchingAppointments ? appointmentsSearchResults[index] : appointments[index]
        }
        let dateString = String(appointment.date?.split(separator: "-").last ?? "")
        let date = dateString.toDate() ?? Date()
        let dateDay = Date.getDateDay(from: date)
        cell.set(calendarDayDate: String(format: "%@ %@", dateDay, Date.localizedDate(date: dateString)))
        cell.set(calendarTitle: appointment.subject ?? "")
        if appointment.attachments?.isEmpty == false {
            cell.showAttachmentsButton()
        }
        cell.set(calendarTime: appointment.time ?? "")
    }
    
    func didSelectItem(atIndex index: Int) {
        switch userSelectedAction {
        case .orders:
            var order: UserOrdersResponse
            if userOrdersStatus == .filter {
                order = isSearchingOrders ? filteredOrdersSearchResults[index] : filteredOrders[index]
            } else {
                order = isSearchingOrders ? ordersSearchResults[index] : orders[index]
            }
            router.navigateToOrderDetailsViewController(withOrderId: order.ticketId)
        case .meetings:
            var meeting: UserMeetingsResponse
            if userMeetingStatus == .filter {
                meeting = isSearchingMeetings ? filteredMeetingsSearchResults[index] : filteredMeetings[index]
            } else {
                meeting = isSearchingMeetings ? meetingsSearchResults[index] : meetings[index]
            }
            router.navigateToMeetingDetailsViewController(withMeetingId: meeting.meetingId)
        case .calendars:
            var appointment: UserAppointmentsResponse
            if userAppointmentsStatus == .filter {
                appointment = isSearchingAppointments ? filteredAppointmentsSearchResults[index] : filteredAppointments[index]
            } else {
                appointment = isSearchingAppointments ? appointmentsSearchResults[index] : appointments[index]
            }
            router.navigateToAppointmentDetailsViewController(withAppointmentId: appointment.id)
        }
    }
}

// MARK: - Search
extension HomePresenter {
    
    func updateIsSearching(_ isSearching: Bool) {
        switch userSelectedAction {
        case .orders: isSearchingOrders = isSearching
        case .meetings: isSearchingMeetings = isSearching
        case .calendars: isSearchingAppointments = isSearching
        }
        view?.refreshCollectionView()
    }
    
    func searchItems(withSearchText searchText: String) {
        switch userSelectedAction {
        case .orders:
            if !searchText.isEmpty {
                switch userOrdersStatus {
                case .defaultAction, .cancel:
                        ordersSearchResults = orders.filter { ($0.subject ?? "").lowercased().contains(searchText.lowercased()) }
                    if ordersSearchResults.isEmpty {
                        view?.showEmptySearchResults()
                    } else {
                        view?.refreshCollectionView()
                    }
                case .filter:
                        filteredOrdersSearchResults = filteredOrders.filter { ($0.subject ?? "").lowercased().contains(searchText.lowercased()) }
                    if filteredOrdersSearchResults.isEmpty {
                        view?.showEmptySearchResults()
                    } else {
                        view?.refreshCollectionView()
                    }
                }
            }
        case .meetings:
            if !searchText.isEmpty {
                print(searchText)
                switch userMeetingStatus {
                case .defaultAction, .cancel:
                        meetingsSearchResults = meetings.filter { ($0.meetingSubject ?? "").lowercased().contains(searchText.lowercased()) }
                    if meetingsSearchResults.isEmpty {
                        view?.showEmptySearchResults()
                    } else {
                        view?.refreshCollectionView()
                    }
                case .filter:
                        filteredMeetingsSearchResults = filteredMeetings.filter { ($0.meetingSubject ?? "").lowercased().contains(searchText.lowercased()) }
                    if filteredMeetingsSearchResults.isEmpty {
                        view?.showEmptySearchResults()
                    } else {
                        view?.refreshCollectionView()
                    }
                }
            }
        case .calendars:
            if !searchText.isEmpty {
                switch userAppointmentsStatus {
                case .defaultAction, .cancel:
                        appointmentsSearchResults = appointments.filter { ($0.subject ?? "").lowercased().contains(searchText.lowercased()) }
                    if appointmentsSearchResults.isEmpty {
                        view?.showEmptySearchResults()
                    } else {
                        view?.refreshCollectionView()
                    }
                case .filter:
                        filteredAppointmentsSearchResults = filteredAppointments.filter { ($0.subject ?? "").lowercased().contains(searchText.lowercased()) }
                    if filteredAppointmentsSearchResults.isEmpty {
                        view?.showEmptySearchResults()
                    } else {
                        view?.refreshCollectionView()
                    }
                }
            }
        }
    }
}
