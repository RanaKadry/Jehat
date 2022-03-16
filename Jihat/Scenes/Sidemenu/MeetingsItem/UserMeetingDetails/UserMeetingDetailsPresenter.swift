//
//  UserMeetingDetailsPresenter.swift
//  Jihat
//
//  Created by Peter Bassem on 05/12/2021.
//  Copyright © 2021 Jehat. All rights reserved.
//
//

import Foundation

// MARK: UserMeetingDetails Presenter -

class UserMeetingDetailsPresenter: BasePresenter {

    weak var view: UserMeetingDetailsViewProtocol?
    private let interactor: UserMeetingDetailsInteractorInputProtocol
    private let router: UserMeetingDetailsRouterProtocol
    private let meetingId: String?
    
    private var detailsItems: [MeetingDetailsTypes] = [.meetingDetails, .meetingTerms, .meetingCandidates]
    private var meetingDetailsType: MeetingDetailsTypes = .meetingDetails
    
    private var meetingDetails: UserMeetingDetailsResponse?
    private var meetingTerms: [UserMeetingTermsResponse]?
    private var meetingCandidates: UserMeetingCandidatesResponse?
    
    init(view: UserMeetingDetailsViewProtocol, interactor: UserMeetingDetailsInteractorInputProtocol, router: UserMeetingDetailsRouterProtocol, meetingId: String?) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.meetingId = meetingId
    }
}

// MARK: - UserMeetingDetailsPresenterProtocol
extension UserMeetingDetailsPresenter: UserMeetingDetailsPresenterProtocol {
    
    func viewDidLoad() {
//        print("meetingId:", meetingId)
        view?.showLoading()
        interactor.getMeetingDetailsData(userMeetingDetailsRequest: UserMeetingDetailsRequest(userToken: interactor.userToken, meetingId: meetingId))
    }
}

// MARK: - API
extension UserMeetingDetailsPresenter: UserMeetingDetailsInteractorOutputProtocol {
    
    func fetchingMeetingDetailsWithSuccess(meetingDetails: UserMeetingDetailsResponse) {
        self.meetingDetails = meetingDetails
        if meetingDetails.candidatesFlag == "0" {
            detailsItems.removeLast()
        }
        view?.refreshAppBarCollectionView()
        
        router.addMeetingDetailsViewController(meetingDetails: meetingDetails) { [weak self] in
            let attendMeetingRequest = UserMeetingDetailsRequest(userToken: self?.interactor.userToken, meetingId: self?.meetingId)
            self?.interactor.attendMeeting(attendMeetingRequest: attendMeetingRequest)
        }
    }
    
    func fetchingAttendMeetingWithSuccess() {
        meetingDetails?.attendFlag = "0"
        didSelectNavigationBarCellItem(atIndex: 0)
    }
    
    func fetchingMeetingTermsWithSuccess(meetingTerms: [UserMeetingTermsResponse]) {
        self.meetingTerms = meetingTerms
        dump(meetingTerms)
        print("----------------------------------")
        router.addMeetingTermsViewController(meetingId: meetingId, meetingTerms: meetingTerms) { [weak self] meetingTerm, meetingTermVoteType  in
            self?.router.navigateToVoteMeetingTermViewController(voteType: meetingTermVoteType, meetingId: self?.meetingId, meetingTerm: meetingTerm, voteMeetingTermCompletion: { [weak self] in
                self?.interactor.getMeetingTermsUpdates(userMeetingDetailsRequest: UserMeetingDetailsRequest(userToken: self?.interactor.userToken, meetingId: self?.meetingId))

            })
        }
    }
    
    func fetchingMeetingCandidatesWithSuccess(meetingCandidates: UserMeetingCandidatesResponse) {
        self.meetingCandidates = meetingCandidates
        router.addMeetingCandidatesViewController(meetingId: meetingId, meetingCandidates: meetingCandidates)
    }
    
    func fetchingMeetingTermsUpdatesWithSuccess(meetingTerms: [UserMeetingTermsResponse]) {
        self.meetingTerms = meetingTerms
        dump(meetingTerms)
        router.showMeetingTermsViewController(meetingTerms: meetingTerms)
    }
    
    func fetchingWithError(error: String) {
        view?.showBottomMessage(error)
    }
    
    func finishFetchingMeetingDetailsData() {
        view?.hideLoading()
        view?.refreshView()
    }
}

// MARK: - Selectors
extension UserMeetingDetailsPresenter {
    
    func performBack() {
        router.popupViewController()
    }
}

// MARK: - NavigationBarCollectionView Setup
extension UserMeetingDetailsPresenter {
    
    var itemsCount: Int {
        return detailsItems.count
    }
    
    func configureNavigationBarCellItem(_ cell: AppNavigationItemCollectionViewCellProtocol, atIndex index: Int) {
        cell.displayItem(title: detailsItems[index].rawValue.localized())
    }
    
    func didSelectNavigationBarCellItem(atIndex index: Int) {
        meetingDetailsType = detailsItems[index]
        if let selectedIndex = detailsItems.firstIndex(where: { $0 == meetingDetailsType }) {
            if (meetingDetailsType == .meetingTerms || meetingDetailsType == .meetingCandidates) && meetingDetails?.attendFlag == "1" {
                view?.showBottomMessage("attend_meeting_first".localized())
                return
            }
            view?.updateAppBarBottomView(atIndex: selectedIndex)
        }
        switch meetingDetailsType {
        case .meetingDetails:
            router.showMeetingDetailsViewController(meetingDetails: meetingDetails)
            router.hideMeetingTermsViewController()
            router.hideMeetingCandidatesViewController()
        case .meetingTerms:
            if meetingDetails?.attendFlag == "0" {
                router.showMeetingTermsViewController(meetingTerms: meetingTerms)
                router.hideMeetingDetailsViewController()
                router.hideMeetingCandidatesViewController()
            }
        case .meetingCandidates:
            if meetingDetails?.attendFlag == "0" {
                router.hideMeetingDetailsViewController()
                router.hideMeetingTermsViewController()
                router.showMeetingCandidatesViewController(meetingCandidates: meetingCandidates)
            }
        }
    }
}
