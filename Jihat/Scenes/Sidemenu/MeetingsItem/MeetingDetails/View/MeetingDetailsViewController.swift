//
//  MeetingDetailsViewController.swift
//  Jihat
//
//  Created by Ahmed Barghash on 04/11/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

final class MeetingDetailsViewController: BaseViewController {

    // MARK: - Outlets
    @IBOutlet private weak var meetingTitleLabel: UILabel!
    @IBOutlet private weak var meetingManagerLabel: UILabel!
    @IBOutlet private weak var meetingIntroductionLabel: UILabel!
    @IBOutlet private weak var meetingDateLabel: UILabel!
    @IBOutlet private weak var meetingTimeLabel: UILabel!
    @IBOutlet private weak var meetingEmployeesLabel: UILabel!
    @IBOutlet private weak var meetingMembersCollectionView: UICollectionView!
    @IBOutlet private weak var collectionViewHeight: NSLayoutConstraint!
    @IBOutlet private weak var attendanceRateLabel: UILabel!
    @IBOutlet private weak var meetingAttachmentsLabel: UILabel!
    @IBOutlet private weak var attachmentsCollectionView: UICollectionView!
    @IBOutlet private weak var attachmentsCollectionViewHeight: NSLayoutConstraint!
    @IBOutlet private weak var attendMeetingButton: TitleWithImageButton!
    
    // MARK: - Variables
	var presenter: MeetingDetailsPresenterProtocol!
    var meetingMembersCollectionViewDataDouceDelegate: CollectionView<MeetingMembetsItemCollectionViewCell>!
    
    var _meetingTitleLabel: UILabel {
        return meetingTitleLabel
    }
    var _meetingManagerLabel: UILabel {
        return meetingManagerLabel
    }
    var _meetingIntroductionLabel: UILabel {
        return meetingIntroductionLabel
    }
    var _meetingDateLabel: UILabel!{
        return meetingDateLabel
    }
    var _meetingTimeLabel: UILabel {
        return meetingTimeLabel
    }
    var _meetingEmployeesLabel: UILabel {
        return meetingEmployeesLabel
    }
    var _meetingMembersCollectionView: UICollectionView {
        return meetingMembersCollectionView
    }
    var _collectionViewHeight: NSLayoutConstraint {
        return collectionViewHeight
    }
    var _attendanceRateLabel: UILabel {
        return attendanceRateLabel
    }
    var _meetingAttachmentsLabel: UILabel {
        return meetingAttachmentsLabel
    }
    private var attachmentsCollectionViewDataSourceDelegate: CollectionView<AttatchmentCollectionViewCell>!
    var _attachmentsCollectionView: UICollectionView {
        return attachmentsCollectionView
    }
    var _attachmentsCollectionViewHeight: NSLayoutConstraint {
        return attachmentsCollectionViewHeight
    }
    var _attendMeetingButton: TitleWithImageButton {
        return attendMeetingButton
    }

    // MARK: - Lifecycle
	override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        presenter.viewDidLoad()
    }
}

// MARK: - Helpers
extension MeetingDetailsViewController {
    
    func setupMeetingMembersCollectionView() {
        meetingMembersCollectionViewDataDouceDelegate = CollectionView(itemsCount: presenter.itemsCount, itemConfigurator: { [weak self] (cell, index) in
            self?.presenter.configureCollectionViewCellItem(cell, atIndex: index)
        }, itemSelector: { [weak self] (index) in
            self?.presenter.didSelectCollectionViewCellItem(atIndex: index)
        }, itemSize: CGSize(width: UIScreen.main.bounds.width - 48, height: 34))
        meetingMembersCollectionView.registerCell(cell: MeetingMembetsItemCollectionViewCell.self)
        meetingMembersCollectionView.dataSource = meetingMembersCollectionViewDataDouceDelegate
        meetingMembersCollectionView.delegate = meetingMembersCollectionViewDataDouceDelegate
        updateCollectionViewHeight()
    }
    
    func updateCollectionViewHeight() {
        meetingMembersCollectionView.reloadData()
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.collectionViewHeight.constant = self.meetingMembersCollectionView.collectionViewLayout.collectionViewContentSize.height
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    func setupAttachmentsCollectionView() {
        let totalSpacing: CGFloat = (2 * sectionInsets.left) + ((numberOfItemsPerRow - 1) * spacingBetweenCells)
        let width = ((UIScreen.main.bounds.width - 28) - totalSpacing) / numberOfItemsPerRow
        attachmentsCollectionViewDataSourceDelegate = CollectionView(itemsCount: presenter.attatchmentsCount, itemConfigurator: { [weak self] cell, index in
            self?.presenter.configureAttatchemtCell(cell, atIndex: index)
        }, itemSelector: { [weak self] index in
            self?.presenter.didSelectAttachemt(atIndex: index)
        }, itemSize: .init(width: width, height: width), itemSpacing: spacingBetweenCells)
        attachmentsCollectionView.registerCell(cell: AttatchmentCollectionViewCell.self)
        attachmentsCollectionView.dataSource = attachmentsCollectionViewDataSourceDelegate
        attachmentsCollectionView.delegate = attachmentsCollectionViewDataSourceDelegate
        attachmentsCollectionView.backgroundColor = .clear
        updateAttachmentsCollectionViewHeight()
    }
    
    private func updateAttachmentsCollectionViewHeight() {
        attachmentsCollectionView.reloadData()
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.attachmentsCollectionViewHeight.constant = self.attachmentsCollectionView.collectionViewLayout.collectionViewContentSize.height
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
    }
}

// MARK: - Selectors
extension MeetingDetailsViewController {
    
    @IBAction
    private func attendMeetingButtonDidPressed(_ sender: Any) {
        presenter.performAttendMeeting()
    }
}
