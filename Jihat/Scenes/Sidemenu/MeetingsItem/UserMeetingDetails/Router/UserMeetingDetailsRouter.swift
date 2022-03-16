//
//  UserMeetingDetailsRouter.swift
//  Jihat
//
//  Created by Peter Bassem on 05/12/2021.
//  Copyright © 2021 Jehat. All rights reserved.
//
//

import UIKit

// MARK: UserMeetingDetails Router -

class UserMeetingDetailsRouter: BaseRouter, UserMeetingDetailsRouterProtocol {
    
    private var meetingDetailsViewController: UIViewController?
    private var meetingTermsViewController: UIViewController?
    private var meetingCandidatesViewController: UIViewController?
    
    static func createModule(meetingId: String?) -> UIViewController {
        let view =  UserMeetingDetailsViewController()

        let interactor = UserMeetingDetailsInteractor(
            useCase: MeetingDetailsUseCase(
                userRepository: UserRepositoryImp(),
                meetingRepository: MeetingRepositoryImp()
            )
        )
        let router = UserMeetingDetailsRouter()
        let presenter = UserMeetingDetailsPresenter(view: view, interactor: interactor, router: router, meetingId: meetingId)
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        return view
    }

    func addMeetingDetailsViewController(meetingDetails: UserMeetingDetailsResponse, attendMeetingAction: @escaping ActionCompletion) {
        meetingDetailsViewController = MeetingDetailsRouter.createModule(meetingDetails: meetingDetails, attendMeetingAction: attendMeetingAction)
        if let userMeetingDetailsViewController = viewController as? UserMeetingDetailsViewController {
            userMeetingDetailsViewController.addChild(meetingDetailsViewController ?? UIViewController())
            meetingDetailsViewController?.view.translatesAutoresizingMaskIntoConstraints = false
            userMeetingDetailsViewController._childrenViewControllerContainerView.addSubview(meetingDetailsViewController?.view ?? UIView())
            meetingDetailsViewController?.view.fillSuperview()
            meetingDetailsViewController?.didMove(toParent: userMeetingDetailsViewController)
        }
    }
    
    func showMeetingDetailsViewController(meetingDetails: UserMeetingDetailsResponse?) {
        meetingDetailsViewController?.view.isHidden = false
        meetingDetailsViewController?.viewDidLoad()
    }
    
    func hideMeetingDetailsViewController() {
        meetingDetailsViewController?.view.isHidden = true
    }
    
    func addMeetingTermsViewController(meetingId: String?, meetingTerms: [UserMeetingTermsResponse], voteTermAction: @escaping VoteTermAction) {
        meetingTermsViewController = MeetingTermsRouter.createModule(meetingId: meetingId, meetingTerms: meetingTerms, voteTermAction: voteTermAction)
        if let userMeetingDetailsViewController = viewController as? UserMeetingDetailsViewController {
            userMeetingDetailsViewController.addChild(meetingTermsViewController ?? UIViewController())
            meetingTermsViewController?.view.translatesAutoresizingMaskIntoConstraints = false
            userMeetingDetailsViewController._childrenViewControllerContainerView.addSubview(meetingTermsViewController?.view ?? UIView())
            meetingTermsViewController?.view.fillSuperview()
            meetingTermsViewController?.didMove(toParent: userMeetingDetailsViewController)
        }
    }
    
    func showMeetingTermsViewController(meetingTerms: [UserMeetingTermsResponse]?) {
        meetingTermsViewController?.view.isHidden = false
        if let meetingTermsViewController = meetingTermsViewController as? MeetingTermsCollectionViewController {
            meetingTermsViewController.presenter.viewDidLoad(meetingTerms: meetingTerms)
        }
    }
    
    func hideMeetingTermsViewController() {
        meetingTermsViewController?.view.isHidden = true
    }
    
    func navigateToVoteMeetingTermViewController(voteType: MeetingTermVoteType, meetingId: String?, meetingTerm: UserMeetingTermsResponse, voteMeetingTermCompletion: @escaping ActionCompletion) {
        let voteRequiredViewController = VoteRequiredRouter.createModule(voteType: voteType, meetingId: meetingId, meetingTerm: meetingTerm, voteMeetingTermCompletion: voteMeetingTermCompletion)
        viewController?.navigationController?.pushViewController(voteRequiredViewController, animated: true)
    }
    
    func addMeetingCandidatesViewController(meetingId: String?, meetingCandidates: UserMeetingCandidatesResponse) {
        meetingCandidatesViewController = CandidatesRouter.createModule(meetingId: meetingId, meetingCandidates: meetingCandidates)
        if let userMeetingDetailsViewController = viewController as? UserMeetingDetailsViewController {
            userMeetingDetailsViewController.addChild(meetingCandidatesViewController ?? UIViewController())
            meetingCandidatesViewController?.view.translatesAutoresizingMaskIntoConstraints = false
            userMeetingDetailsViewController._childrenViewControllerContainerView.addSubview(meetingCandidatesViewController?.view ?? UIView())
            meetingCandidatesViewController?.view.fillSuperview()
            meetingCandidatesViewController?.didMove(toParent: userMeetingDetailsViewController)
        }
    }
    
    func showMeetingCandidatesViewController(meetingCandidates: UserMeetingCandidatesResponse?) {
        meetingCandidatesViewController?.view.isHidden = false
        meetingCandidatesViewController?.viewDidLoad()
    }
    
    func hideMeetingCandidatesViewController() {
        meetingCandidatesViewController?.view.isHidden = true
    }
}
