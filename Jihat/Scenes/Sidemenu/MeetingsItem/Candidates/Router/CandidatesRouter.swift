//
//  CandidatesRouter.swift
//  Jihat
//
//  Created by Ahmed Barghash on 13/11/2021.
//  Copyright © 2021 Jehat. All rights reserved.
//
//

import UIKit

// MARK: Candidates Router -

class CandidatesRouter: BaseRouter, CandidatesRouterProtocol {
    
    static func createModule(meetingId: String?, meetingCandidates: UserMeetingCandidatesResponse) -> UIViewController {
        let view =  CandidatesViewController()

        let interactor = CandidatesInteractor(
            useCase: CandidatesUseCase(
                userRepository: UserRepositoryImp(),
                meetingRepository: MeetingRepositoryImp()
            )
        )
        let router = CandidatesRouter()
        let presenter = CandidatesPresenter(view: view, interactor: interactor, router: router, meetingId: meetingId, meetingCandidates: meetingCandidates)
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        return view
    }

}
