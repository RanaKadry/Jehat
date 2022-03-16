//
//  VoteRequiredRouter.swift
//  Jihat
//
//  Created by Ahmed Barghash on 05/11/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

// MARK: VoteRequired Router -

class VoteRequiredRouter: BaseRouter, VoteRequiredRouterProtocol {
    
    static func createModule(voteType: MeetingTermVoteType, meetingId: String?, meetingTerm: UserMeetingTermsResponse, voteMeetingTermCompletion: @escaping ActionCompletion) -> UIViewController {
        let view =  VoteRequiredViewController()

        let interactor = VoteRequiredInteractor(
            useCase: VoteMeetingTermUseCase(
                userRepository: UserRepositoryImp(),
                meetingRepository: MeetingRepositoryImp()
            )
        )
        let router = VoteRequiredRouter()
        let presenter = VoteRequiredPresenter(view: view, interactor: interactor, router: router, voteType: voteType, meetingId: meetingId, meetingTerm: meetingTerm, voteMeetingTermCompletion: voteMeetingTermCompletion)
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        return view
    }
}
