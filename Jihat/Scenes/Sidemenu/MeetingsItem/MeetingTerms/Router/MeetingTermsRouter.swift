//
//  MeetingTermsRouter.swift
//  Jihat
//
//  Created by Peter Bassem on 08/12/2021.
//  Copyright © 2021 Jehat. All rights reserved.
//
//

import UIKit

// MARK: MeetingTerms Router -

class MeetingTermsRouter: BaseRouter, MeetingTermsRouterProtocol {
    
    static func createModule(meetingId: String?, meetingTerms: [UserMeetingTermsResponse], voteTermAction: @escaping VoteTermAction) -> UIViewController {
        let view =  MeetingTermsCollectionViewController()

        let interactor = MeetingTermsInteractor()
        let router = MeetingTermsRouter()
        let presenter = MeetingTermsPresenter(view: view, interactor: interactor, router: router, meetingId: meetingId, meetingTerms: meetingTerms, voteTermAction: voteTermAction)
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        return view
    }
}
