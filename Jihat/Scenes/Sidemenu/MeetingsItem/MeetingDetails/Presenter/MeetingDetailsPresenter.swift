//
//  MeetingDetailsPresenter.swift
//  Jihat
//
//  Created by Ahmed Barghash on 04/11/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

// MARK: MeetingDetails Presenter -

class MeetingDetailsPresenter: BasePresenter {

    weak var view: MeetingDetailsViewProtocol?
    private let interactor: MeetingDetailsInteractorInputProtocol
    private let router: MeetingDetailsRouterProtocol
    private let meetingDetails: UserMeetingDetailsResponse
    private let attendMeetingAction: ActionCompletion
    
    private var meetingEmployees: [String] = []
    private var meetingMembers: [MeetingMemberModel] = []
    private var attachments: [String] = []
    
    init(view: MeetingDetailsViewProtocol, interactor: MeetingDetailsInteractorInputProtocol, router: MeetingDetailsRouterProtocol, meetingDetails: UserMeetingDetailsResponse, attendMeetingAction: @escaping ActionCompletion) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.meetingDetails = meetingDetails
        self.attendMeetingAction = attendMeetingAction
    }
}

// MARK: - MeetingDetailsPresenterProtocol
extension MeetingDetailsPresenter: MeetingDetailsPresenterProtocol {
    
    func viewDidLoad() {
        if meetingDetails.attendFlag == "1" {
            view?.showAttendMeetingButton()
        } else {
            view?.hideAttendMeetingButton()
        }
        view?.setMeetingTitle(meetingDetails.meetingName ?? "")
        view?.setMeetingManager(meetingDetails.meetingManger ?? "")
        view?.setMeetingDescription(meetingDetails.meetingDiscription ?? "")
        view?.setMeetingDate(Date.localizedDate(date: meetingDetails.meetingDate ?? ""))
        view?.setMeetingTime(meetingDetails.meetingTime ?? "")

        meetingEmployees.removeAll()
        (meetingDetails.attendEmployees ?? []).forEach { meetingEmployees.append(String(format: "%@ (%@) %@", "•", "attend".localized(), $0)) }
        (meetingDetails.absentEmployees ?? []).forEach { meetingEmployees.append(String(format: "%@ (%@) %@", "•", "absent".localized(), $0)) }
        view?.setMeetingEmployees(meetingEmployees.joined(separator: "\n"))

        meetingMembers.removeAll()
        (meetingDetails.attendClients ?? []).forEach { meetingMembers.append(MeetingMemberModel(memberName: $0, memberStatus: "attend".localized())) }
        (meetingDetails.absentClients ?? []).forEach { meetingMembers.append(MeetingMemberModel(memberName: $0, memberStatus: "absent".localized())) }
        view?.refreshMeetingMembersCollectionView()
        
        let attendanceRate = String(format: "%@ %@ - %@ %@ \t %@", meetingDetails.attendText?.toInt()?.localized() ?? "", meetingDetails.attendLabel ?? "", meetingDetails.absentText?.toInt()?.localized() ?? "", meetingDetails.absentLabel ?? "", meetingDetails.percentageText ?? "")
        view?.setMeetingAttendanceRate(attendanceRate)
        
        let attachmentsCount = LocalizationHelper.isArabic() ? meetingDetails.attachments?.count.toString().enToArDigits : meetingDetails.attachments?.count.toString().arToEnDigits
        view?.setMeetingAttachmentsCount(String(format: "%@ %@ %@", "number".localized(), (attachmentsCount ?? ""), "attached_files".localized()))
        self.attachments = meetingDetails.attachments ?? []
        view?.refreshMeetingAttachmentsCollectionView()
    }
}

// MARK: - API
extension MeetingDetailsPresenter: MeetingDetailsInteractorOutputProtocol {
    
    func fetchingDownloadedDocumentWithSuccess(localFileUrl: URL) {
        router.presentDocumentPreveiwViewController(fileurl: localFileUrl)
    }
}

// MARK: - Selectors
extension MeetingDetailsPresenter {
    
    func performAttendMeeting() {
        attendMeetingAction()
    }
}

// MARK: - MeetingMemberCollectionView Setup
extension MeetingDetailsPresenter {
    
    var itemsCount: Int {
        return meetingMembers.count
    }
    
    func configureCollectionViewCellItem(_ cell: MeetingMembetsItemCollectionViewCell, atIndex index: Int) {
        let memberData = meetingMembers[index]
        cell.set(memberNameAndStatus: "• (\(memberData.memberStatus)) \(memberData.memberName)")
    }
    
    func didSelectCollectionViewCellItem(atIndex index: Int) {
        print("Cell Tapped...")
    }
}

// MARK: - AttatchmentsCollectionView Setup
extension MeetingDetailsPresenter {
    
    var attatchmentsCount: Int {
        return attachments.count
    }
    
    func configureAttatchemtCell(_ cell: AttatchmentCollectionViewCellProtocol, atIndex index: Int) {
        let attachment = attachments[index]
        if (attachment).contains("jpeg") || (attachment).contains("jpg") {
            cell.setImage(attachment)
        } else {
            if (attachment).contains("pdf") {
                cell.setImage(image: DesignSystem.Icon.pdf.image)
            } else if (attachment).contains("doc") {
                cell.setImage(image: DesignSystem.Icon.word.image)
            } else if (attachment).contains("xls") {
                cell.setImage(image: DesignSystem.Icon.excel.image)
            } else if (attachment).contains("ppt") {
                cell.setImage(image: DesignSystem.Icon.powerpoint.image)
            } else if (attachment).contains("txt") {
                cell.setImage(image: DesignSystem.Icon.txt.image)
            }
        }
    }
    
    func didSelectAttachemt(atIndex index: Int) {
        guard let attachmentURL = URL(string: attachments[index]) else { return }
        interactor.downloadDocument(fileurl: attachmentURL)
    }
}
