//
//  CandidatesProtocols.swift
//  Jihat
//
//  Created by Ahmed Barghash on 13/11/2021.
//  Copyright © 2021 Jehat. All rights reserved.
//
//

import Foundation

// MARK: Candidates Protocols

protocol CandidatesViewProtocol: BaseViewProtocol {
    var presenter: CandidatesPresenterProtocol! { get set }
    
    func removeStackViewTopConstraint()
    func removeStackViewBottomConstraint()
    func hideMeetingSharesCountStackView()
    func hideMeetingSharesTitlesStackView()
    func set(meetingTitle: String)
    func set(candidatesNumberOrSharesNumber: String)
    func refreshCandidatesSharesCollectionView()
    func refreshDisributeCandidatesSharesCollectionView()
    func refreshMultiDistributeCandidatesSharesCollectionView()
    func refreshCollectionView()
    func set(chooseCandidateOrSharesNumber: String)
    func setupVoteRequiredButton()
    func setupVoteDoneButton()
    func enableVoteRequiredButton()
    func disableVoteRequiredButton()
}

protocol CandidatesPresenterProtocol: BasePresenterProtocol {
    var view: CandidatesViewProtocol? { get set }
    
    func viewDidLoad()
    
    func performValidateInputs()
    
    var itemsCount: Int { get }
    
    func configureCandidateShareCell(_ cell: ChooseCandidateItemCollectionViewCell, atIndex index: Int)
    func didSelectCandidate(_ cell: ChooseCandidateItemCollectionViewCell, atIndex index: Int)
    func didDeselectCandidate(_ cell: ChooseCandidateItemCollectionViewCell, atIndex index: Int)
    
    func configureDistrubuteCandidateShareCell(_ cell: DistributeSharesCollectionViewCellProtocol, atIndex index: Int)
    func didUpdateShareValue(_ cell: DistributeSharesCollectionViewCellProtocol, atIndex index: Int, parentIndex: Int?, shareValue: String)
    func candidateName(atIndex index: Int) -> String
    
    func configureMultiDistributeCandidateShareCell(_ cell: MultiDistributeSharesItemCollectionViewCellProtocol, atIndex index: Int)
        
    func performVoteRequired()

}

protocol CandidatesRouterProtocol: BaseRouterProtocol {
    
}

protocol CandidatesInteractorInputProtocol: BaseInteractorInputProtocol {
    var presenter: CandidatesInteractorOutputProtocol? { get set }
    
    var userToken: String? { get }
    func voteMeetingCandidates(voteMeetingCandidate: UserMeetingDetailsRequest, bodyData: Data)
    func voteMeetingCandidatesTypeTwo(voteMeetingCandidate: UserMeetingDetailsRequest, bodyData: Data)
    func voteMeetingCandidatesTypeThree(voteMeetingCandidate: UserMeetingDetailsRequest, bodyData: Data)
}

protocol CandidatesInteractorOutputProtocol: BaseInteractorOutputProtocol {
    func fetchingVoteCadidateWithSuccess(message: String)
    func fetchingVoteCandidateWithError(error: String)
}
