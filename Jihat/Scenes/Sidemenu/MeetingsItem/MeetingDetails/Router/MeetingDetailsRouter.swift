//
//  MeetingDetailsRouter.swift
//  Jihat
//
//  Created by Ahmed Barghash on 04/11/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

// MARK: MeetingDetails Router -

class MeetingDetailsRouter: BaseRouter, MeetingDetailsRouterProtocol {
    
    static func createModule(meetingDetails: UserMeetingDetailsResponse, attendMeetingAction: @escaping ActionCompletion) -> UIViewController {
        let view =  MeetingDetailsViewController()

        let interactor = MeetingDetailsInteractor(
            useCase: MeetingDetailsTypeUseCase(
                documentRepository: DocumentRepositoryImp()
            )
        )
        let router = MeetingDetailsRouter()
        let presenter = MeetingDetailsPresenter(view: view, interactor: interactor, router: router, meetingDetails: meetingDetails, attendMeetingAction: attendMeetingAction)
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        return view
    }

}
