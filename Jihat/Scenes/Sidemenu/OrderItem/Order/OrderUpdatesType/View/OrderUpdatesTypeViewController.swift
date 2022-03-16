//
//  OrderUpdatesTypeViewController.swift
//  Jihat
//
//  Created by Peter Bassem on 30/09/2021.
//

import UIKit

final class OrderUpdatesTypeViewController: BaseViewController {
    
    // MARK: - Outlets
    @IBOutlet private weak var collectionView: UICollectionView!

    // MARK: - Variables
    var presenter: OrderUpdatesTypePresenterProtocol!
    
    var _collectionView: UICollectionView {
        return collectionView
    }
    
    private var updatedHeight = false
    var attachmentImagesCollectionViewHeight: CGFloat = 0.0 {
        didSet { configureUpdateHeight() }
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        presenter.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupCollectionView()
    }
}


// MARK: - Helpers
extension OrderUpdatesTypeViewController {
    
    func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.registerCell(cell: TextMessageCollectionViewCell.self)
        collectionView.registerCell(cell: VoiceNoteCollectionViewCell.self)
        collectionView.registerCell(cell: AttachmentCollectionViewCell.self)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
    }
    
    private func configureUpdateHeight() {
        if !updatedHeight {
            collectionView.reloadData()
            updatedHeight = true
        }
    }
    
    private func getViewIndexInCollectionView(collectionView: UICollectionView, view: UIView) -> IndexPath? {
        let pos = view.convert(CGPoint.zero, to: collectionView)
        return collectionView.indexPathForItem(at: pos)
    }
    
    func changeButtonImage(_ button: UIButton, play: Bool) {
        UIView.transition(with: button, duration: 0.4,
                          options: .transitionCrossDissolve, animations: {
            button.setImage(play ? DesignSystem.Icon.playButton.image : DesignSystem.Icon.pauseButton.image, for: .normal)
        }, completion: nil)
    }
}

// MARK: - Selectors
extension OrderUpdatesTypeViewController {
    
    @objc
    private func voiceNoteButtonDidPressed(_ sender: UIButton) {
        if let indexPath = getViewIndexInCollectionView(collectionView: collectionView, view: sender) {
            presenter.performVoiceNoteButtonPressed(atIndex: indexPath.item)
        }
    }
    
    @IBAction
    private func sendTextMessageButtonDidPressed(_ sender: AlignableButton) {
        presenter.performAddText()
    }
    
    @IBAction
    private func sendVoiceNoteButtonDidPressed(_ sender: AlignableButton) {
        presenter.performAddVoiceNote()
    }
    
    @IBAction
    private func sendAttachmentButtonDidPressed(_ sender: AlignableButton) {
        presenter.performAddAttachment()
    }
}

// MARK: - UICollectionViewDataSource
extension OrderUpdatesTypeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.itemsCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch presenter.commentType(atIndex: indexPath.item) {
        case .text:
            let cell = collectionView.dequeueCell(at: indexPath) as TextMessageCollectionViewCell
            presenter.configureTextMessageCell(cell, atIndex: indexPath.item)
            return cell
        case .voiceNote:
            let cell = collectionView.dequeueCell(at: indexPath) as VoiceNoteCollectionViewCell
            cell._playPauseButton.addTarget(self, action: #selector(voiceNoteButtonDidPressed(_:)), for: .touchUpInside)
            presenter.configureVoiceNoteCell(cell, atIndex: indexPath.item)
            return cell
        case .attachment:
            let cell = collectionView.dequeueCell(at: indexPath) as AttachmentCollectionViewCell
            presenter.configureAttachmentCell(cell, atIndex: indexPath.item)
            cell.updatedCollectionViewHeight = { [weak self] collectionHeight in
                self?.attachmentImagesCollectionViewHeight = collectionHeight
            }
            return cell
        }

//        ***********************************AttachmentCollectionViewCell***********************************
//        let cell = collectionView.dequeueCell(at: indexPath) as AttachmentCollectionViewCell
//        presenter.configureAttachmentCell(cell, atIndex: indexPath.item)
//        cell.updatedCollectionViewHeight = { [weak self] collectionHeight in
//            self?.attachmentImagesCollectionViewHeight = collectionHeight
//        }
//        return cell
//        ***********************************AttachmentCollectionViewCell***********************************

//        ***********************************TextMessageCollectionViewCell***********************************
//        let cell = collectionView.dequeueCell(at: indexPath) as TextMessageCollectionViewCell
//        presenter.configureTextMessageCell(cell, atIndex: indexPath.item)
//        return cell
//        ***********************************TextMessageCollectionViewCell***********************************
        
//        ***********************************VoiceNoteCollectionViewCell***********************************
//        let cell = collectionView.dequeueCell(at: indexPath) as VoiceNoteCollectionViewCell
//        cell.index = indexPath.item
//        cell.delegate = self
//        return cell
//        ***********************************VoiceNoteCollectionViewCell***********************************
    }
}

// MARK: - UICollectionViewDelegate
extension OrderUpdatesTypeViewController: UICollectionViewDelegate { }

// MARK: - UICollectionViewDelegateFlowLayout
extension OrderUpdatesTypeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch presenter.commentType(atIndex: indexPath.item) {
        case .text:
            // Cell height: 33 (upper view height) + 16 (message text label top constraint) + message label text height + 16 (message text label bottom constraint)
            let messageHeight = presenter.textMessage(atIndex: indexPath.item).heightForView(font: DesignSystem.Typography.asterisk.font, width: collectionView.frame.size.width - 64)
            let height = 33 + 16 + messageHeight + 16
            return .init(width: UIScreen.main.bounds.width - 32, height: height)
        case .voiceNote:
            let cell = collectionView.dequeueCell(at: indexPath) as VoiceNoteCollectionViewCell
            cell.layoutSubviews()
            let messageHeight = presenter.textMessage(atIndex: indexPath.item).heightForView(font: DesignSystem.Typography.asterisk.font, width: cell.textMessageLabelWidth)
            let height = 33 + 16 + messageHeight + 16
            return .init(width: UIScreen.main.bounds.width - 32, height: height)
        case .attachment:
            // Cell height: 33 (upper view height) + 16 (attatchemtsCountLabel top constraint) + message label text height + 16 (attatchemtsCountLabel bottom constraint) + collectionview height) + 16 (collectionview bottom constraint)
            let messageHeight = presenter.textMessage(atIndex: indexPath.item).heightForView(font: DesignSystem.Typography.defaultFont.font, width: collectionView.frame.size.width - 64)
            let height = 33 + 16 + messageHeight + 16 + attachmentImagesCollectionViewHeight + 16
            return .init(width: UIScreen.main.bounds.width - 32, height: height)
        }
        
//        ***********************************AttachmentCollectionViewCell***********************************
//        // Cell height: 33 (upper view height) + 16 (attatchemtsCountLabel top constraint) + 30 (attatchemtsCountLabelHeight) + 16 (attatchemtsCountLabel bottom constraint) + collectionview height) + 16 (collectionview bottom constraint)
//        let height = 33 + 16 + 30 + 16 + attachmentImagesCollectionViewHeight + 16
//        return .init(width: UIScreen.main.bounds.width - 32, height: height)
//        ***********************************AttachmentCollectionViewCell***********************************
        
//        ***********************************TextMessageCollectionViewCell***********************************
//        // Cell height: 33 (upper view height) + 16 (message text label top constraint) + message label text height + 16 (message text label bottom constraint)
//        let messageHeight = presenter.textMessage(atIndex: indexPath.item).heightForView(font: DesignSystem.Typography.asterisk.font, width: collectionView.frame.size.width - 64)
//        let height = 33 + 16 + messageHeight + 16
//        return .init(width: UIScreen.main.bounds.width - 32, height: height)
//        ***********************************TextMessageCollectionViewCell***********************************
        
//        ***********************************VoiceNoteCollectionViewCell***********************************
//                return .init(width: UIScreen.main.bounds.width - 32, height: 100)
//        ***********************************VoiceNoteCollectionViewCell***********************************

    }
}
