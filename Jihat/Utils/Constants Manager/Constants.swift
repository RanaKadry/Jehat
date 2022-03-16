//
//  Constants.swift
//  Driver
//
//  Created by Peter Bassem on 12/24/20.
//  Copyright © 2020 Peter Bassem. All rights reserved.
//

import UIKit

// MARK: - ViewControllerID
enum ViewControllerID: String {
    case splashViewController
}

// MARK: -
enum StoryboardID: String {
    case splash
}

// MARK: - Typealias
typealias SideMenuSelectionItem = ((SideMenuItems) -> Void)
typealias ActionCompletion = () -> Void
typealias UpdateViewHeight = (Double) -> Void
typealias UpdateProfileCompletion = ((UserDataResponse) -> Void)?
typealias FilterOrderCompletion = ((_ filterOrderItem: TicketFilterItemsResponse) -> Void)?
typealias FilterMeetingCompletion = ((_ filterMeetingItem: MeetingFilterItemsResponse) -> Void)?
typealias FilterAppointmentCompletion = ((_ startDate: String?, _ endDate: String?) -> Void)?
typealias AttachmentSelection = ((URL) -> Void)
typealias DepartmentSelection = ((DepartmentsResponse) -> Void)
typealias OrderTypeSelection = (TransactionTypesResponse) -> Void
typealias SearchItemSelection<T: Codable> = ((T) -> Void)

// MARK: - Global Constants
enum GlobalConstants: String {
    case kSuccess = "success"
    case loginAsAgentUrl = "https://gtm.easygo.systems"
    case kTermsAndConditionsUrl = "https://www.mandobee.com/index.php?route=information/information&information_id=5"
    case contactUsPhone = "00201225675342"
}

// MARK: - CollectionView Constants
let sectionInsets = UIEdgeInsets.init(top: 0, left: 10, bottom: 0, right: 10)
let numberOfItemsPerRow: CGFloat = 3
let spacingBetweenCells: CGFloat = 10

// MARK: -
var keyWindow: UIWindow? {
    if #available(iOS 13.0, *) {
        return UIApplication.shared.windows.first
    } else {
        return UIApplication.shared.keyWindow
    }
}

var screenWidth: CGFloat {
    UIScreen.main.bounds.width
}

var screenHeight: CGFloat {
    UIScreen.main.bounds.height
}

let appDelegate = UIApplication.shared.delegate as? AppDelegate

@available(iOS 13.0, *)
let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
