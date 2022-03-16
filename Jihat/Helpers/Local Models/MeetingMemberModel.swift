//
//  MeetingMemberModel.swift
//  Jihat
//
//  Created by Peter Bassem on 06/12/2021.
//  Copyright © 2021 Jehat. All rights reserved.
//

import Foundation

struct MeetingMemberModel {
    let memberName: String
    let memberStatus: String
    
    init(memberName: String, memberStatus: String) {
        self.memberName = memberName
        self.memberStatus = memberStatus
    }
}
