//
//  MeetingTermsProtocols.swift
//  Jihat
//
//  Created by Peter Bassem on 08/12/2021.
//  Copyright © 2021 Jehat. All rights reserved.
//
//

import Foundation

// MARK: MeetingTerms Protocols

protocol MeetingTermsViewProtocol: BaseViewProtocol {
    var presenter: MeetingTermsPresenterProtocol! { get set }
    
    func refreshCollectionView()
}

protocol MeetingTermsPresenterProtocol: BasePresenterProtocol {
    var view: MeetingTermsViewProtocol? { get set }
    
    func viewDidLoad(meetingTerms: [UserMeetingTermsResponse]?)

    var meetingsCount: Int { get }
    func configureMeetingTermCell(_ cell: MeetingTermCollectionViewCellProtocol, atIndex index: Int)
    func termText(atIndex index: Int) -> String
    func performVoteButtonPressed(atIndex index: Int)
}

protocol MeetingTermsRouterProtocol: BaseRouterProtocol {
    
}

protocol MeetingTermsInteractorInputProtocol: BaseInteractorInputProtocol {
    var presenter: MeetingTermsInteractorOutputProtocol? { get set }
    
}

protocol MeetingTermsInteractorOutputProtocol: BaseInteractorOutputProtocol {
    
}
