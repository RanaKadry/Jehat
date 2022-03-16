//
//  MeetingDetailsViewController+Delegates.swift
//  Jihat
//
//  Created by Ahmed Barghash on 04/11/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

extension MeetingDetailsViewController: MeetingDetailsViewProtocol {
    
    func setMeetingTitle(_ title: String) {
        _meetingTitleLabel.text = title
    }
    
    func setMeetingManager(_ manager: String) {
        _meetingManagerLabel.text = manager
    }
    
    func setMeetingDescription(_ description: String) {
        _meetingIntroductionLabel.text = description
    }
    
    func setMeetingDate(_ date: String) {
        _meetingDateLabel.text = date
    }
    
    func setMeetingTime(_ time: String) {
        _meetingTimeLabel.text = time
    }
    
    func setMeetingEmployees(_ employees: String) {
        _meetingEmployeesLabel.text = employees
    }
    
    func refreshMeetingMembersCollectionView() {
        setupMeetingMembersCollectionView()
    }
    
    func setMeetingAttendanceRate(_ attendanceRate: String) {
        _attendanceRateLabel.text = attendanceRate
    }
    
    func setMeetingAttachmentsCount(_ count: String) {
        _meetingAttachmentsLabel.text = count
    }
    
    func refreshMeetingAttachmentsCollectionView() {
        setupAttachmentsCollectionView()
    }
    
    func showAttendMeetingButton() {
        _attendMeetingButton.animate(hidden: false)
    }
    
    func hideAttendMeetingButton() {
        _attendMeetingButton.animate(hidden: true)
    }
}
