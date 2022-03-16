//
//  CandidatesInteractor.swift
//  Jihat
//
//  Created by Ahmed Barghash on 13/11/2021.
//  Copyright © 2021 Jehat. All rights reserved.
//
//

import Foundation

// MARK: Candidates Interactor -

class CandidatesInteractor: CandidatesInteractorInputProtocol {
    
    weak var presenter: CandidatesInteractorOutputProtocol?
    private let useCase: CandidatesUseCase
    
    init(useCase: CandidatesUseCase) {
        self.useCase = useCase
    }
    
    var userToken: String? {
        return useCase.userToken
    }
    
    func voteMeetingCandidates(voteMeetingCandidate: UserMeetingDetailsRequest, bodyData: Data) {
        useCase.voteMeetingCandidates(voteMeetingCandidate: voteMeetingCandidate, bodyData: bodyData) { [weak self] result in
            switch result {
            case .success(let voteMeetingCandidateResponse):
                DispatchQueue.main.async {
                    self?.presenter?.fetchingVoteCadidateWithSuccess(message: voteMeetingCandidateResponse.message ?? "")
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.presenter?.fetchingVoteCandidateWithError(error: error.rawValue.localized())
                }
            }
        }
    }
    
    func voteMeetingCandidatesTypeTwo(voteMeetingCandidate: UserMeetingDetailsRequest, bodyData: Data) {
        useCase.voteMeetingCandidatesTypeTwo(voteMeetingCandidate: voteMeetingCandidate, bodyData: bodyData) { [weak self] result in
            switch result {
            case .success(let voteMeetingCandidateResponse):
                DispatchQueue.main.async {
                    self?.presenter?.fetchingVoteCadidateWithSuccess(message: voteMeetingCandidateResponse.message ?? "")
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.presenter?.fetchingVoteCandidateWithError(error: error.rawValue.localized())
                }
            }
        }
    }
    
    func voteMeetingCandidatesTypeThree(voteMeetingCandidate: UserMeetingDetailsRequest, bodyData: Data) {
        useCase.voteMeetingCandidatesTypeThree(voteMeetingCandidate: voteMeetingCandidate, bodyData: bodyData) { [weak self] result in
            switch result {
            case .success(let voteMeetingCandidateResponse):
                DispatchQueue.main.async {
                    self?.presenter?.fetchingVoteCadidateWithSuccess(message: voteMeetingCandidateResponse.message ?? "")
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.presenter?.fetchingVoteCandidateWithError(error: error.rawValue.localized())
                }
            }
        }
    }
}
