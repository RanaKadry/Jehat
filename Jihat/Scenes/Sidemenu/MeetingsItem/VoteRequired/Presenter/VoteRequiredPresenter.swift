//
//  VoteRequiredPresenter.swift
//  Jihat
//
//  Created by Ahmed Barghash on 05/11/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

// MARK: VoteRequired Presenter -

class VoteRequiredPresenter: BasePresenter {

    weak var view: VoteRequiredViewProtocol?
    private let interactor: VoteRequiredInteractorInputProtocol
    private let router: VoteRequiredRouterProtocol
    private let voteType: MeetingTermVoteType
    private let meetingId: String?
    private var meetingTerm: UserMeetingTermsResponse
    private let voteMeetingTermCompletion: ActionCompletion
    
    private var agreement: AgreementType?
    private var attachmentsData: [String: [Data]] = [:]
    private var imagesData: [Data] = []
    
    init(view: VoteRequiredViewProtocol, interactor: VoteRequiredInteractorInputProtocol, router: VoteRequiredRouterProtocol, voteType: MeetingTermVoteType, meetingId: String?, meetingTerm: UserMeetingTermsResponse, voteMeetingTermCompletion: @escaping ActionCompletion) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.voteType = voteType
        self.meetingId = meetingId
        self.meetingTerm = meetingTerm
        self.voteMeetingTermCompletion = voteMeetingTermCompletion
    }
}

// MARK: - VoteRequiredPresenterProtocol
extension VoteRequiredPresenter: VoteRequiredPresenterProtocol {
    
    func viewDidLoad() {
        view?.set(voteNumbers: meetingTerm.countVotes ?? "") // String(format: "%@ %@", "vote_numbers".localized(), meetingTerm.countVotes?.toInt()?.localized() ?? "")
        view?.set(approversNumbers: meetingTerm.countAgree ?? "") //String(format: "%@ %@", "approvers".localized(), meetingTerm.countAgree?.toInt()?.localized() ?? "")
        view?.set(disapprovesNumbers: meetingTerm.countNotAgree ?? "") // String(format: "%@ %@", "disapproves".localized(), meetingTerm.countNotAgree?.toInt()?.localized() ?? "")
        view?.set(meetingTerm: meetingTerm.term ?? "")
        if meetingTerm.vote != "" {
            if meetingTerm.vote == "Agree" {
                view?.selectAgreeRadioButton()
                agreement = .agree
            } else {
                view?.selectDisagreeRadioButton()
                agreement = .disagree
            }
        }
    }
    
    func validateInputs() {
        let validateInputs = agreement != nil // && comment?.isEmpty == false && comment != "tap_to_insert".localized()
        validateInputs ? view?.enableVoteButton() : view?.disableVoteButton()
    }
}

// MARK: - API
extension VoteRequiredPresenter: VoteRequiredInteractorOutputProtocol {
    
    func fetchingVoteMeetingTermWithSucess(message: String) {
        view?.stopLoadingOnVoteButton()
        view?.showBottomMessage(message)
        meetingTerm.voteFlag = "0"
        voteMeetingTermCompletion()
        router.popupViewController()
    }
    
    func fetchingVoteMeetingTermWithError(error: String) {
        view?.stopLoadingOnVoteButton()
        view?.showBottomMessage(error)
    }
}

// MARK: - Selectors
extension VoteRequiredPresenter {
    
    func performBack() {
        router.popupViewController()
    }
    
    func didSelectAgreement(agreement: AgreementType?) {
        self.agreement = agreement
    }
    
    func performAttachDocuments() {
        attachmentsData.removeAll()
        router.presentDocumentsPickerMultiScreenViewController { [weak self] urls in
            urls.forEach {
                do {
                    let fileExtension = String($0.lastPathComponent.split(separator: ".").last!)
                    let urlData = try Data(contentsOf: $0)
                                        
                    if fileExtension.lowercased().contains("pdf") {
                        if self?.attachmentsData["pdf"] != nil {
                            self?.attachmentsData["pdf"]?.append(urlData)
                        } else {
                            self?.attachmentsData["pdf"] = [urlData]
                        }
                    } else if fileExtension.lowercased().contains("txt") {
                        if self?.attachmentsData["txt"] != nil {
                            self?.attachmentsData["txt"]?.append(urlData)
                        } else {
                            self?.attachmentsData["txt"] = [urlData]
                        }
                    } else if fileExtension.lowercased().contains("doc") {
                        if self?.attachmentsData["doc"] != nil {
                            self?.attachmentsData["doc"]?.append(urlData)
                        } else {
                            self?.attachmentsData["doc"] = [urlData]
                        }
                    } else if fileExtension.lowercased().contains("xls") {
                        if self?.attachmentsData["xls"] != nil {
                            self?.attachmentsData["xls"]?.append(urlData)
                        } else {
                            self?.attachmentsData["xls"] = [urlData]
                        }
                    } else if fileExtension.lowercased().contains("ppt") {
                        if self?.attachmentsData["ppt"] != nil {
                            self?.attachmentsData["ppt"]?.append(urlData)
                        } else {
                            self?.attachmentsData["ppt"] = [urlData]
                        }
                    }
                } catch let error {
                    print("Failed to convert attachment to url:", error)
                }
            }
            self?.view?.set(attachedFilesNumber: String(format: "%@ %@", (urls.count.localized() ?? ""), "attachments_selected".localized()))
        }
    }
    
    func performPickUpImages() {
        router.presentImagePickerMultiSelectViewController(imagesLimit: 5) { [weak self] images, _ in
            self?.imagesData = images.map { $0.jpegData(compressionQuality: 0.8) ?? Data() }
            self?.view?.set(pickedImagesNumber: String(format: "%@ %@", (images.count.localized() ?? ""), "images_selected".localized()))
        }
    }
    
    func performVote(comment: String?) {
        view?.showLoadingOnVoteButton()
        let sendComment = comment == "add_comment".localized() ? "-" : comment
        let userMeetingTermVoteRequest = UserMeetingTermVoteRequest(userToken: interactor.userToken, meetingId: meetingId, termId: meetingTerm.id, vote: agreement?.rawValue.toString(), comment: sendComment)
        switch voteType {
        case .create:
            interactor.voteMeetingTerm(userMeetingTermVoteRequest: userMeetingTermVoteRequest, attachments: attachmentsData, images: imagesData)
        case .edit:
            interactor.editVoteMeetingTerm(userMeetingTermVoteRequest: userMeetingTermVoteRequest, attachments: attachmentsData, images: imagesData)
        }
    }
}
