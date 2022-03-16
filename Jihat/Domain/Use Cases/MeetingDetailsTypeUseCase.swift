//
//  MeetingDetailsTypeUseCase.swift
//  Jihat
//
//  Created by Peter Bassem on 15/12/2021.
//  Copyright © 2021 Jehat. All rights reserved.
//

import Foundation

class MeetingDetailsTypeUseCase {
    private let documentRepository: DocumentRepository
    
    init(documentRepository: DocumentRepository) {
        self.documentRepository = documentRepository
    }
    
    // ----------------
    // MARK: - DOCUEMNT
    // ----------------
    func downloadDocument(fileurl: URL, completion: @escaping (URL?) -> Void) {
        documentRepository.downloadDocument(fileurl: fileurl, completion: completion)
    }
}
