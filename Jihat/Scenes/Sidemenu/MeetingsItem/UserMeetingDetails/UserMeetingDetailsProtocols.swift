//
//  UserMeetingDetailsProtocols.swift
//  Jihat
//
//  Created by Peter Bassem on 05/12/2021.
//  Copyright © 2021 Jehat. All rights reserved.
//
//

import Foundation

// MARK: UserMeetingDetails Protocols

protocol UserMeetingDetailsViewProtocol: BaseViewProtocol {
    var presenter: UserMeetingDetailsPresenterProtocol! { get set }
    
    func updateAppBarBottomView(atIndex index: Int)
    func refreshAppBarCollectionView()
    func refreshView()
}

protocol UserMeetingDetailsPresenterProtocol: BasePresenterProtocol {
    var view: UserMeetingDetailsViewProtocol? { get set }
    
    func viewDidLoad()

    var itemsCount: Int { get }
    func configureNavigationBarCellItem(_ cell: AppNavigationItemCollectionViewCellProtocol, atIndex index: Int)
    func didSelectNavigationBarCellItem(atIndex index: Int)
    
    func performBack()
}

protocol UserMeetingDetailsRouterProtocol: BaseRouterProtocol {
    func addMeetingDetailsViewController(meetingDetails: UserMeetingDetailsResponse, attendMeetingAction: @escaping ActionCompletion)
    func showMeetingDetailsViewController(meetingDetails: UserMeetingDetailsResponse?)
    func hideMeetingDetailsViewController()
    
    func addMeetingTermsViewController(meetingId: String?, meetingTerms: [UserMeetingTermsResponse], voteTermAction: @escaping VoteTermAction)
    func showMeetingTermsViewController(meetingTerms: [UserMeetingTermsResponse]?)
    func hideMeetingTermsViewController()
    func navigateToVoteMeetingTermViewController(voteType: MeetingTermVoteType, meetingId: String?, meetingTerm: UserMeetingTermsResponse, voteMeetingTermCompletion: @escaping ActionCompletion)
    
    func addMeetingCandidatesViewController(meetingId: String?, meetingCandidates: UserMeetingCandidatesResponse)
    func showMeetingCandidatesViewController(meetingCandidates: UserMeetingCandidatesResponse?)
    func hideMeetingCandidatesViewController()
}

protocol UserMeetingDetailsInteractorInputProtocol: BaseInteractorInputProtocol {
    var presenter: UserMeetingDetailsInteractorOutputProtocol? { get set }
    
    var userToken: String? { get }
    func getMeetingDetailsData(userMeetingDetailsRequest: UserMeetingDetailsRequest)
    func attendMeeting(attendMeetingRequest: UserMeetingDetailsRequest)
    func getMeetingTermsUpdates(userMeetingDetailsRequest: UserMeetingDetailsRequest)
}

protocol UserMeetingDetailsInteractorOutputProtocol: BaseInteractorOutputProtocol {
    func fetchingMeetingDetailsWithSuccess(meetingDetails: UserMeetingDetailsResponse)
    func fetchingMeetingTermsWithSuccess(meetingTerms: [UserMeetingTermsResponse])
    func fetchingMeetingCandidatesWithSuccess(meetingCandidates: UserMeetingCandidatesResponse)
    func fetchingAttendMeetingWithSuccess()
    func fetchingWithError(error: String)
    func fetchingMeetingTermsUpdatesWithSuccess(meetingTerms: [UserMeetingTermsResponse])
    func finishFetchingMeetingDetailsData()
}
