//
//  FilterMeetingRouter.swift
//  Jihat
//
//  Created by Peter Bassem on 28/11/2021.
//  Copyright © 2021 Jehat. All rights reserved.
//
//

import UIKit

// MARK: FilterMeeting Router -

class FilterMeetingRouter: BaseRouter, FilterMeetingRouterProtocol {
    
    static func createModule(meetingFilterItems: [MeetingFilterItemsResponse], filterMeetingCompletion: FilterMeetingCompletion) -> UIViewController {
        let view =  FilterMeetingViewController()

        let interactor = FilterMeetingInteractor()
        let router = FilterMeetingRouter()
        let presenter = FilterMeetingPresenter(view: view, interactor: interactor, router: router, meetingFilterItems: meetingFilterItems, filterMeetingCompletion: filterMeetingCompletion)
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        return view
    }

}
