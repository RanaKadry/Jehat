//
//  CandidatesViewController.swift
//  Jihat
//
//  Created by Ahmed Barghash on 13/11/2021.
//  Copyright © 2021 Jehat. All rights reserved.
//
//

import UIKit

final class CandidatesViewController: BaseViewController {

    // MARK: - Outlets
    @IBOutlet private weak var stackViewTopConstraint: NSLayoutConstraint!
    @IBOutlet private weak var stackViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet private weak var meetingSharesCountStackView: UIStackView!
    @IBOutlet private weak var meetingSharesTitlesStackView: UIStackView!
    @IBOutlet private weak var meetingTitleLabel: UILabel!
    @IBOutlet private weak var candidatesOrSharesNumberLabel: UILabel!
    @IBOutlet private weak var chooseOrSharesNumberLabel: UILabel!
    @IBOutlet private weak var candidatesCollectionView: UICollectionView!
    @IBOutlet private weak var collectionViewHeight: NSLayoutConstraint!
    @IBOutlet private weak var voteRequiredButton: UIButton!
    
    // MARK: - Variables
	var presenter: CandidatesPresenterProtocol!
    
    var _stackViewTopConstraint: NSLayoutConstraint {
        return stackViewTopConstraint
    }
    var _stackViewBottomConstraint: NSLayoutConstraint {
        return stackViewBottomConstraint
    }
    var _meetingSharesCountStackView: UIStackView {
        return meetingSharesCountStackView
    }
    var _meetingSharesTitlesStackView: UIStackView {
        return meetingSharesTitlesStackView
    }
    var _meetingTitleLabel: UILabel!{
        return meetingTitleLabel
    }
    var _candidatesOrSharesNumberLabel: UILabel!{
        return candidatesOrSharesNumberLabel
    }
    var _chooseOrSharesNumberLabel: UILabel!{
        return chooseOrSharesNumberLabel
    }
    private var candidatesSharedCollectionViewDataSourceDelegate: CollectionViewDynamicCellSize<ChooseCandidateItemCollectionViewCell>!
    private var distrubuteCandidateSharescollectionViewDataSetUp: CollectionViewDynamicCellSize<DistributeSharesItemCollectionViewCell>!
    private var multiDistributeCandidateSharesCollectionViewDtaSetup: CollectionViewDynamicCellSize<MultiDistributeSharesItemCollectionViewCell>!
    private var updatedHeight = false
    private var multiDistributionInnerCollectionViewHeiht: CGFloat = 0.0 {
        didSet { configureUpdateHeight() }
    }
    var _candidatesCollectionView: UICollectionView!{
        return candidatesCollectionView
    }
    var _collectionViewHeight: NSLayoutConstraint!{
        return collectionViewHeight
    }
    var _voteRequiredButton: UIButton!{
        return voteRequiredButton
    }

    // MARK: - Lifecycle
	override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        presenter.viewDidLoad()
        presenter.performValidateInputs()
    }
}

// MARK: - Helpers
extension CandidatesViewController {
    
    func setupCandidatesSharesCollectionView() {
        candidatesSharedCollectionViewDataSourceDelegate = CollectionViewDynamicCellSize(itemsCount: presenter.itemsCount, itemConfigurator: { [weak self] (cell, index) in
            cell.index = index
            cell.delegate = self
            self?.presenter.configureCandidateShareCell(cell, atIndex: index)
        }, itemSelector: { _ in }, itemSize: { [unowned self] index in
            let width = UIScreen.main.bounds.width - 48
            let candidateNameHeight = self.presenter.candidateName(atIndex: index).heightForView(font: DesignSystem.Typography.action.font, width: width * 0.5)
            return .init(width: width, height: candidateNameHeight)
        }, itemSpacing: 8)
        candidatesCollectionView.registerCell(cell: ChooseCandidateItemCollectionViewCell.self)
        candidatesCollectionView.dataSource = candidatesSharedCollectionViewDataSourceDelegate
        candidatesCollectionView.delegate = candidatesSharedCollectionViewDataSourceDelegate
        updateCollectionViewHeight()
    }
    
    func setupDisributeCandidatesSharesCollectionView() {
        distrubuteCandidateSharescollectionViewDataSetUp = CollectionViewDynamicCellSize(itemsCount: presenter.itemsCount, itemConfigurator: { [unowned self] cell, index in
            cell.index = index
            cell.delegate = self
            self.presenter.configureDistrubuteCandidateShareCell(cell, atIndex: index)
        }, itemSelector: { _ in }, itemSize: { [unowned self] index in
            let width = UIScreen.main.bounds.width - 48
            let candidateNameHeight = self.presenter.candidateName(atIndex: index).heightForView(font: DesignSystem.Typography.action.font, width: width * 0.5)
            return .init(width: width, height: candidateNameHeight)
        }, itemSpacing: 8)
        candidatesCollectionView.registerCell(cell: DistributeSharesItemCollectionViewCell.self)
        candidatesCollectionView.dataSource = distrubuteCandidateSharescollectionViewDataSetUp
        candidatesCollectionView.delegate = distrubuteCandidateSharescollectionViewDataSetUp
        updateCollectionViewHeight()
    }
    
    func setupMultiDistributeCandidatesSharesCollectionView() {
        multiDistributeCandidateSharesCollectionViewDtaSetup = CollectionViewDynamicCellSize(itemsCount: presenter.itemsCount, itemConfigurator: { [weak self] cell, index in
            self?.presenter.configureMultiDistributeCandidateShareCell(cell, atIndex: index)
            cell.collectionViewReference = self
            cell.collectionViewHeightCompletion = { [weak self] height in
                self?.multiDistributionInnerCollectionViewHeiht = height
            }
        }, itemSelector: { _ in }, itemSize: { [unowned self] index in
            let width = screenWidth - 48
            
            let mainTitleHeight = "candidates.type.candidatesDistribution_title".localized().heightForView(font: DesignSystem.Typography.action.font, width: width)
            let height = 24 + mainTitleHeight + 16 + 26.5 + 24 + 34 + 24 + multiDistributionInnerCollectionViewHeiht
            return .init(width: width, height: height)
        }, itemSpacing: 8)
        candidatesCollectionView.registerCell(cell: MultiDistributeSharesItemCollectionViewCell.self)
        candidatesCollectionView.dataSource = multiDistributeCandidateSharesCollectionViewDtaSetup
        candidatesCollectionView.delegate = multiDistributeCandidateSharesCollectionViewDtaSetup
        updateCollectionViewHeight()
    }
    
    func updateCollectionViewHeight() {
        candidatesCollectionView.reloadData()
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.collectionViewHeight.constant = self.candidatesCollectionView.collectionViewLayout.collectionViewContentSize.height
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    private func configureUpdateHeight() {
        if !updatedHeight {
            candidatesCollectionView.reloadData()
            updatedHeight = true
        }
    }
}

// MARK: - Selectors
extension CandidatesViewController {
    
    @IBAction
    private func voteRequiredButtonDidPressed(_ sender: SpinnerButton) {
        presenter.performVoteRequired()
    }
}

// MARK: - ChooseCandidateItemCollectionViewCellDelegate
extension CandidatesViewController: ChooseCandidateItemCollectionViewCellDelegate {
    
    func didSelectCandidate(_ cell: ChooseCandidateItemCollectionViewCell, atIndex index: Int) {
        presenter.didSelectCandidate(cell, atIndex: index)
        presenter.performValidateInputs()
    }
    
    func didDeselectCandidate(_ cell: ChooseCandidateItemCollectionViewCell, atIndex index: Int) {
        presenter.didDeselectCandidate(cell, atIndex: index)
        presenter.performValidateInputs()
    }
}

// MARK: - DistributeSharesItemCollectionViewCellDelegate
extension CandidatesViewController: DistributeSharesItemCollectionViewCellDelegate {
    func didEndUpdateShareValue(_ cell: DistributeSharesCollectionViewCellProtocol, atIndex index: Int, parentIndex: Int?, shareValue: String) { }
    
    
    func didUpdateShareValue(_ cell: DistributeSharesCollectionViewCellProtocol, atIndex index: Int, parentIndex: Int?, shareValue: String) {
        presenter.didUpdateShareValue(cell, atIndex: index, parentIndex: parentIndex, shareValue: shareValue)
        presenter.performValidateInputs()
    }
}
