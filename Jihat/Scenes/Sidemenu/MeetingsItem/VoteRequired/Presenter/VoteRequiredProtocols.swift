//
//  VoteRequiredProtocols.swift
//  Jihat
//
//  Created by Ahmed Barghash on 05/11/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

// MARK: VoteRequired Protocols

protocol VoteRequiredViewProtocol: BaseViewProtocol {
    var presenter: VoteRequiredPresenterProtocol! { get set }
    
    func set(voteNumbers: String)
    func set(approversNumbers: String)
    func set(disapprovesNumbers: String)
    func set(meetingTerm: String)
    func selectAgreeRadioButton()
    func selectDisagreeRadioButton()
    func set(attachedFilesNumber: String)
    func set(pickedImagesNumber: String)
    func showLoadingOnVoteButton()
    func stopLoadingOnVoteButton()
    func enableVoteButton()
    func disableVoteButton()
}

protocol VoteRequiredPresenterProtocol: BasePresenterProtocol {
    var view: VoteRequiredViewProtocol? { get set }
    
    func viewDidLoad()
    
    func validateInputs()
    
    func performBack()
    func didSelectAgreement(agreement: AgreementType?)
    func performAttachDocuments()
    func performPickUpImages()
    func performVote(comment: String?)

}

protocol VoteRequiredRouterProtocol: BaseRouterProtocol {
    
}

protocol VoteRequiredInteractorInputProtocol: BaseInteractorInputProtocol {
    var presenter: VoteRequiredInteractorOutputProtocol? { get set }
    
    var userToken: String? { get }
    func voteMeetingTerm(userMeetingTermVoteRequest: UserMeetingTermVoteRequest, attachments: [String: [Data]], images: [Data])
    func editVoteMeetingTerm(userMeetingTermVoteRequest: UserMeetingTermVoteRequest, attachments: [String: [Data]], images: [Data])
}

protocol VoteRequiredInteractorOutputProtocol: BaseInteractorOutputProtocol {
    func fetchingVoteMeetingTermWithSucess(message: String)
    func fetchingVoteMeetingTermWithError(error: String)
}
