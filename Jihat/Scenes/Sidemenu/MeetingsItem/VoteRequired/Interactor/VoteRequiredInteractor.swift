//
//  VoteRequiredInteractor.swift
//  Jihat
//
//  Created by Ahmed Barghash on 05/11/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

// MARK: VoteRequired Interactor -

class VoteRequiredInteractor: VoteRequiredInteractorInputProtocol {
    
    weak var presenter: VoteRequiredInteractorOutputProtocol?
    private let useCase: VoteMeetingTermUseCase
    
    init(useCase: VoteMeetingTermUseCase) {
        self.useCase = useCase
    }
    
    var userToken: String? {
        return useCase.userToken
    }
    
    func voteMeetingTerm(userMeetingTermVoteRequest: UserMeetingTermVoteRequest, attachments: [String: [Data]], images: [Data]) {
        useCase.voteMeetingTerm(userMeetingTermVoteRequest: userMeetingTermVoteRequest, attachments: attachments, images: images) { [weak self] result in
            switch result {
            case .success(let voteMeetingResponse):
                if voteMeetingResponse.status == true {
                    DispatchQueue.main.async {
                        self?.presenter?.fetchingVoteMeetingTermWithSucess(message: voteMeetingResponse.message ?? "")
                    }
                } else {
                    DispatchQueue.main.async {
                        self?.presenter?.fetchingVoteMeetingTermWithError(error: voteMeetingResponse.message ?? "")
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.presenter?.fetchingVoteMeetingTermWithError(error: error.rawValue.localized())
                }
            }
        }
    }
    
    func editVoteMeetingTerm(userMeetingTermVoteRequest: UserMeetingTermVoteRequest, attachments: [String: [Data]], images: [Data]) {
        useCase.editVoteMeetingTerm(userMeetingTermVoteRequest: userMeetingTermVoteRequest, attachments: attachments, images: images) { [weak self] result in
            switch result {
            case .success(let voteMeetingResponse):
                if voteMeetingResponse.status == true {
                    DispatchQueue.main.async {
                        self?.presenter?.fetchingVoteMeetingTermWithSucess(message: voteMeetingResponse.message ?? "")
                    }
                } else {
                    DispatchQueue.main.async {
                        self?.presenter?.fetchingVoteMeetingTermWithError(error: voteMeetingResponse.message ?? "")
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.presenter?.fetchingVoteMeetingTermWithError(error: error.rawValue.localized())
                }
            }
        }
    }
}
