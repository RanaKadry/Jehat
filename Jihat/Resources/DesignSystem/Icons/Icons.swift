//
//  Icons.swift
//  Jihat
//
//  Created by Peter Bassem on 13/09/2021.
//

import Foundation
import UIKit

extension DesignSystem {
    
    enum Icon: String {
        case background
        case logo
        case iconSuccess
        case iconError
        case error
        case success
        case visibilityOff = "visibility_off"
        case visibilityOn = "visibility_on"
        case defaultUserImage = "default_user_image"
        case anyVehicle = "AnyVehicle"
        case carVehicle = "CarVehicle"
        case footVehicle = "FootVehicle"
        case motorcycleVehicle = "MotorcycleVehicle"
        case wheelVehicle = "WheelVehicle"
        case myOrders = "my_orders"
        case myMeetings = "my_meetings"
        case myCalendar = "my_calendar"
        case filter = "filter"
        case calendar = "sidemenu.my_calendar"
        case addOrder = "add_order"
        case addOrderCancelAlert = "add_order_cancel_alert"
        case addOrderSuccessfullyAlert = "add_order_successfully_alert"
        case itemStatus = "item_status"
        case attachemtPlaceholder = "attachemt_placeholder"
        case pauseButton = "pause-button"
        case playButton = "play-button"
        case recordButton = "record-button"
        case registerSuccessfully = "register_successfully"
        case upArrow = "up_arrow"
        case downArrow = "down_arrow"
        case close = "Close"
        case excel, pdf, powerpoint, txt, word
        
        var image: UIImage {
            return UIImage(named: self.rawValue)!
        }
    }
}
