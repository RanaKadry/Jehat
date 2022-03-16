//
//  MeetingTermsPresenter.swift
//  Jihat
//
//  Created by Peter Bassem on 08/12/2021.
//  Copyright © 2021 Jehat. All rights reserved.
//
//

import Foundation

// MARK: MeetingTerms Presenter -

typealias VoteTermAction = ((UserMeetingTermsResponse, MeetingTermVoteType) -> Void)

class MeetingTermsPresenter: BasePresenter {

    weak var view: MeetingTermsViewProtocol?
    private let interactor: MeetingTermsInteractorInputProtocol
    private let router: MeetingTermsRouterProtocol
    private let meetingId: String?
    private var meetingTerms: [UserMeetingTermsResponse]
    private let voteTermAction: VoteTermAction
    
    init(view: MeetingTermsViewProtocol, interactor: MeetingTermsInteractorInputProtocol, router: MeetingTermsRouterProtocol, meetingId: String?, meetingTerms: [UserMeetingTermsResponse], voteTermAction: @escaping VoteTermAction) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.meetingId = meetingId
        self.meetingTerms = meetingTerms
        self.voteTermAction = voteTermAction
    }
}

// MARK: - MeetingTermsPresenterProtocol
extension MeetingTermsPresenter: MeetingTermsPresenterProtocol {
    
    func viewDidLoad(meetingTerms: [UserMeetingTermsResponse]?) {
        self.meetingTerms = meetingTerms ?? []
        view?.refreshCollectionView()
    }
}

// MARK: - API
extension MeetingTermsPresenter: MeetingTermsInteractorOutputProtocol {
    
}

// MARK: - Selectors
extension MeetingTermsPresenter {
    
}

// MARK: - CollectionView setup
extension MeetingTermsPresenter {
    
    var meetingsCount: Int {
        return meetingTerms.count
    }
    
    func configureMeetingTermCell(_ cell: MeetingTermCollectionViewCellProtocol, atIndex index: Int) {
        let meetingTerm = meetingTerms[index]
        cell.set(voteNumbers: meetingTerm.countVotes ?? "") // String(format: "%@ %@", "vote_numbers".localized(), )
        cell.set(approversNumbers: meetingTerm.countAgree ?? "") // String(format: "%@ %@", "approvers".localized(), )
        cell.set(disapprovesNumbers: meetingTerm.countNotAgree ?? "") // String(format: "%@ %@", "disapproves".localized(), )
        cell.set(meetingTerm: meetingTerm.term ?? "")
        if meetingTerm.voteFlag == "1" {
            cell.setupVoteRequiredButton()
        } else {
            if meetingTerm.editFlag == "1" {
                cell.setupVoteDoneButton(title: String(format: "%@ (%@)", "been_voted".localized(), "edit".localized()))
            } else {
                cell.setupVoteDoneButton(title: "been_voted".localized())
            }
        }
    }
    
    func termText(atIndex index: Int) -> String {
        return meetingTerms[index].term ?? ""
    }
    
    func performVoteButtonPressed(atIndex index: Int) {
        if meetingTerms[index].voteFlag == "1"  {
            voteTermAction(meetingTerms[index], .create)
        } else if meetingTerms[index].voteFlag == "0" {
            if meetingTerms[index].editFlag == "1" {
                voteTermAction(meetingTerms[index], .edit)
            } else {
                view?.showBottomMessage("vote_ended".localized())
            }
        }
    }
}
