//
//  CandidatesPresenter.swift
//  Jihat
//
//  Created by Ahmed Barghash on 13/11/2021.
//  Copyright © 2021 Jehat. All rights reserved.
//
//

import Foundation

// MARK: Candidates Presenter -

struct VoteCandidatesShares: Codable {
    let candidateId: String?
    let candidateShares: String?
    
    enum CodingKeys: String, CodingKey {
        case candidateId = "Candidate_ID"
        case candidateShares = "Candidate_Shares"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        candidateId = try values.decodeIfPresent(String.self, forKey: .candidateId)
        candidateShares = try values.decodeIfPresent(String.self, forKey: .candidateShares)
    }
    
    init(candidateId: String?, candidateShares: String?) {
        self.candidateId = candidateId
        self.candidateShares = candidateShares
    }
}

struct MultiSharesCandidteVote: Codable {
    let maximumShares: Int?
    let agentName: String?
    var candidates: [AllCandidatesResponse]?
    var sum = 0
    let agentId: String?
}

struct MultiVoteCandidatesShares: Codable {
    let candidateId: String?
    let candidateShares: String?
    let agentId: String?
    
    enum CodingKeys: String, CodingKey {
        case candidateId = "Candidate_ID"
        case candidateShares = "Candidate_Shares"
        case agentId = "Agent_ID"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        candidateId = try values.decodeIfPresent(String.self, forKey: .candidateId)
        candidateShares = try values.decodeIfPresent(String.self, forKey: .candidateShares)
        agentId = try values.decodeIfPresent(String.self, forKey: .agentId)
    }
    
    init(candidateId: String?, candidateShares: String?, agentId: String?) {
        self.candidateId = candidateId
        self.candidateShares = candidateShares
        self.agentId = agentId
    }
}

class CandidatesPresenter: BasePresenter {

    weak var view: CandidatesViewProtocol?
    private let interactor: CandidatesInteractorInputProtocol
    private let router: CandidatesRouterProtocol
    private let meetingId: String?
    private let meetingCandidates: UserMeetingCandidatesResponse
    
    private var candidates: [AllCandidatesResponse] = []
    private var multiSharesCandidteVote: [MultiSharesCandidteVote] = []
    
    init(view: CandidatesViewProtocol, interactor: CandidatesInteractorInputProtocol, router: CandidatesRouterProtocol, meetingId: String?, meetingCandidates: UserMeetingCandidatesResponse) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.meetingId = meetingId
        self.meetingCandidates = meetingCandidates
    }
}

// MARK: - CandidatesPresenterProtocol
extension CandidatesPresenter: CandidatesPresenterProtocol {
    
    func viewDidLoad() {
        if meetingCandidates.candidatesType == "1" {
            candidates = meetingCandidates.allCandidates ?? []
            view?.set(meetingTitle: "candidates.type.candidatesShares_title".localized())
            view?.set(candidatesNumberOrSharesNumber: String(format: "%@ (%@) %@", "choose".localized(), meetingCandidates.seatsStocks?.localized() ?? "", "candidates".localized()))
            view?.set(chooseCandidateOrSharesNumber: "shares_number".localized())
            view?.refreshCandidatesSharesCollectionView()
        } else if meetingCandidates.candidatesType == "2" {
            candidates = meetingCandidates.allCandidates ?? []
            view?.set(meetingTitle: "candidates.type.candidatesDistribution_title".localized())
            view?.set(candidatesNumberOrSharesNumber: String(format: "%@: %@", "number_of_shares".localized(), meetingCandidates.seatsStocks?.localized() ?? ""))
            view?.set(chooseCandidateOrSharesNumber: "shares_number".localized())
            view?.refreshDisributeCandidatesSharesCollectionView()
        } else if meetingCandidates.candidatesType == "3" {
            view?.removeStackViewTopConstraint()
            view?.removeStackViewBottomConstraint()
            view?.hideMeetingSharesCountStackView()
            view?.hideMeetingSharesTitlesStackView()
            multiSharesCandidteVote.removeAll()
            multiSharesCandidteVote.append(MultiSharesCandidteVote(maximumShares: meetingCandidates.seatsStocks, agentName: nil, candidates: meetingCandidates.allCandidates, agentId: "0"))
            multiSharesCandidteVote.append(contentsOf: meetingCandidates.agentFor!.map { MultiSharesCandidteVote(maximumShares: $0.cSeatsStocks?.toInt(), agentName: $0.cName, candidates: meetingCandidates.allCandidates, agentId: $0.cID) })
            view?.refreshMultiDistributeCandidatesSharesCollectionView()
        }
    }
    
    func performValidateInputs() {
        if meetingCandidates.candidatesType == "1" {
            if candidates.map ({ $0.selectedCandidate }).allSatisfy({ $0 == "" }) {
                view?.disableVoteRequiredButton()
            } else {
                if candidates.filter ({ $0.selectedCandidate != "" }).count > (meetingCandidates.seatsStocks ?? -1) {
                    view?.disableVoteRequiredButton()
                } else {
                    view?.enableVoteRequiredButton()
                }
            }
        } else if meetingCandidates.candidatesType == "2" {
            if candidates.map ({ $0.selectedCandidateShare }).allSatisfy({ $0 == 0 }) {
                view?.disableVoteRequiredButton()
            } else {
                if  candidates.filter ({ $0.selectedCandidateShare != 0 }).map ({ $0.selectedCandidateShare }).reduce(0, +) > (meetingCandidates.seatsStocks ?? -1) {
                    view?.disableVoteRequiredButton()
                } else {
                    view?.enableVoteRequiredButton()
                }
            }
        } else if meetingCandidates.candidatesType == "3" {
            
        }
    }
    
    func performValidateTypeThree() {
        for (index, item) in multiSharesCandidteVote.enumerated() {
            if item.candidates!.map ({ $0.selectedCandidateShare }).allSatisfy({ $0 == 0 }) && item.sum > item.maximumShares! {
                view?.enableVoteRequiredButton()
            } else {
                view?.disableVoteRequiredButton()
            }
        }
    }
}

// MARK: - API
extension CandidatesPresenter: CandidatesInteractorOutputProtocol {
    
    func fetchingVoteCadidateWithSuccess(message: String) {
        view?.showBottomMessage(message)
    }
    
    func fetchingVoteCandidateWithError(error: String) {
        view?.showBottomMessage(error)
    }
}

// MARK: - Selectors
extension CandidatesPresenter {
    
    func performVoteRequired() {
        let voteMeetingCandidate = UserMeetingDetailsRequest(userToken: interactor.userToken, meetingId: meetingId)
        if meetingCandidates.candidatesType == "1" {
            let selectedCandidateIdsData = candidates.map { $0.selectedCandidate }.filter { $0 != "" }.stringArrayToData() ?? Data()
            interactor.voteMeetingCandidates(voteMeetingCandidate: voteMeetingCandidate, bodyData: selectedCandidateIdsData)
        } else if meetingCandidates.candidatesType == "2" {
            let candidateShares = candidates.map { VoteCandidatesShares(candidateId: $0.id, candidateShares: $0.selectedCandidateShare.toString()) }
            print("candidateShares:", candidateShares)
            do {
                let candidateSharesData = try JSONEncoder().encode(candidateShares)
                interactor.voteMeetingCandidatesTypeTwo(voteMeetingCandidate: voteMeetingCandidate, bodyData: candidateSharesData)
            } catch {
                print("Failed to encode Canditate type two:", error)
            }
            
        } else if meetingCandidates.candidatesType == "3" {
            var mutliVoteMeetingCandidatesShares: [MultiVoteCandidatesShares] = []
            multiSharesCandidteVote.forEach { multiShareCandidate in
                mutliVoteMeetingCandidatesShares.append(contentsOf: multiShareCandidate.candidates!.map { MultiVoteCandidatesShares(candidateId: $0.id, candidateShares: $0.selectedCandidateShare.toString(), agentId: multiShareCandidate.agentId) })
            }
            do {
                let mutliVoteMeetingCandidatesSharesData = try JSONEncoder().encode(mutliVoteMeetingCandidatesShares)
                interactor.voteMeetingCandidatesTypeThree(voteMeetingCandidate: voteMeetingCandidate, bodyData: mutliVoteMeetingCandidatesSharesData)
            } catch {
                print("Failed to encode Canditate type two:", error)
            }
        }
    }
}

// MARK: - CandidatesCollectionView Setup
extension CandidatesPresenter {
    
    var itemsCount: Int {
        if meetingCandidates.candidatesType == "1" || meetingCandidates.candidatesType == "2" {
            return candidates.count
        } else {
            return multiSharesCandidteVote.count
        }
    }
    
    func configureCandidateShareCell(_ cell: ChooseCandidateItemCollectionViewCell, atIndex index: Int) {
        cell.set(candidateName: candidates[index].name ?? "")
    }
    
    func didSelectCandidate(_ cell: ChooseCandidateItemCollectionViewCell, atIndex index: Int) {
        if candidates.filter ({ $0.selectedCandidate != "" }).count < (meetingCandidates.seatsStocks ?? -1) {
            candidates[index].selectedCandidate = candidates[index].id ?? ""
        } else {
            cell.disableCooseCandidateCheckBox()
            view?.showBottomMessage("exceed_candidate_shares".localized())
        }
    }
    
    func didDeselectCandidate(_ cell: ChooseCandidateItemCollectionViewCell, atIndex index: Int) {
        candidates[index].selectedCandidate = ""
    }
    
    func configureDistrubuteCandidateShareCell(_ cell: DistributeSharesCollectionViewCellProtocol, atIndex index: Int) {
        if  candidates.filter ({ $0.selectedCandidateShare != 0 }).map ({ $0.selectedCandidateShare }).reduce(0, +) < (meetingCandidates.seatsStocks ?? -1) {
            cell.set(candidateName: candidates[index].name ?? "")
        } 
    }
    
    func didUpdateShareValue(_ cell: DistributeSharesCollectionViewCellProtocol, atIndex index: Int, parentIndex: Int?, shareValue: String) {
        
        if meetingCandidates.candidatesType == "2" {
            candidates[index].selectedCandidateShare = shareValue.toInt() ?? 0
        } else if meetingCandidates.candidatesType == "3" {
            if let parentIndex = parentIndex {
                multiSharesCandidteVote[parentIndex].candidates?[index].selectedCandidateShare = shareValue.toInt() ?? 0
            }
        }
    }
    
    func candidateName(atIndex index: Int) -> String {
        return candidates[index].name ?? ""
    }
    
    func configureMultiDistributeCandidateShareCell(_ cell: MultiDistributeSharesItemCollectionViewCellProtocol, atIndex index: Int) {
        cell.set(candidatesNumberOrSharesNumber: String(format: "%@: %@", multiSharesCandidteVote[index].agentName == nil ? "number_of_shares".localized() : "\("other_number_of_shares".localized()) \(multiSharesCandidteVote[index].agentName ?? "")", multiSharesCandidteVote[index].maximumShares?.localized() ?? ""))
        
        cell.setupDisributeCandidatesSharesCollectionView(itemsCount: multiSharesCandidteVote[index].candidates?.count ?? 0) { [weak self] mCell, mIndex in
            var sCell = mCell
            sCell.set(candidateName: self?.multiSharesCandidteVote[index].candidates?[mIndex].name ?? "")
            sCell.index = mIndex
            sCell.parentIndex = index
            sCell.delegate = self
        } itemSize: { [unowned self] mIndex in
            let width = screenWidth - 48
            let candidateNameHeight = self.multiSharesCandidteVote[index].candidates?[mIndex].name?.heightForView(font: DesignSystem.Typography.action.font, width: width * 0.5) ?? 0.0
            return .init(width: width, height: candidateNameHeight)
        }
    }
}

// MARK: - DistributeSharesItemCollectionViewCellDelegate
extension CandidatesPresenter: DistributeSharesItemCollectionViewCellDelegate {
    
    func didEndUpdateShareValue(_ cell: DistributeSharesCollectionViewCellProtocol, atIndex index: Int, parentIndex: Int?, shareValue: String) {
        if let parentIndex = parentIndex {
            multiSharesCandidteVote[parentIndex].sum += (shareValue.toInt() ?? -1)
        }
    }
}
