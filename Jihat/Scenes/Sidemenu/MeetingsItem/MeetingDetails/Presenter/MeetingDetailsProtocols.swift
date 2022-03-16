//
//  MeetingDetailsProtocols.swift
//  Jihat
//
//  Created by Ahmed Barghash on 04/11/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

// MARK: MeetingDetails Protocols

protocol MeetingDetailsViewProtocol: BaseViewProtocol {
    var presenter: MeetingDetailsPresenterProtocol! { get set }
    
    func setMeetingTitle(_ title: String)
    func setMeetingManager(_ manager: String)
    func setMeetingDescription(_ description: String)
    func setMeetingDate(_ date: String)
    func setMeetingTime(_ time: String)
    func setMeetingEmployees(_ employees: String)
    func refreshMeetingMembersCollectionView()
    func setMeetingAttendanceRate(_ attendanceRate: String)
    func setMeetingAttachmentsCount(_ count: String)
    func refreshMeetingAttachmentsCollectionView()
    
    func showAttendMeetingButton()
    func hideAttendMeetingButton()
}

protocol MeetingDetailsPresenterProtocol: BasePresenterProtocol {
    var view: MeetingDetailsViewProtocol? { get set }
    
    func viewDidLoad()
    
    var itemsCount: Int { get }
    func configureCollectionViewCellItem(_ cell: MeetingMembetsItemCollectionViewCell, atIndex index: Int)
    func didSelectCollectionViewCellItem(atIndex index: Int)
    
    var attatchmentsCount: Int { get }
    func configureAttatchemtCell(_ cell: AttatchmentCollectionViewCellProtocol, atIndex index: Int)
    func didSelectAttachemt(atIndex index: Int)
    
    func performAttendMeeting()

}

protocol MeetingDetailsRouterProtocol: BaseRouterProtocol {
    
}

protocol MeetingDetailsInteractorInputProtocol: BaseInteractorInputProtocol {
    var presenter: MeetingDetailsInteractorOutputProtocol? { get set }
    
    func downloadDocument(fileurl: URL)
}

protocol MeetingDetailsInteractorOutputProtocol: BaseInteractorOutputProtocol {
    func fetchingDownloadedDocumentWithSuccess(localFileUrl: URL)
}
