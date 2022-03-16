//
//  AttachmentCollectionViewCell.swift
//  Jihat
//
//  Created by Peter Bassem on 08/10/2021.
//

import UIKit

protocol AttachmentCollectionViewCellProtocol {
    func display(messageOwner: String)
    func display(messageDate: String)
    func display(attachmentsTitle: String)
    func display(attachments: [String], attachmentSelection: @escaping AttachmentSelection)
}

class AttachmentCollectionViewCell: BaseCollectionViewCell {
    
    // MARK: - Outlets
    @IBOutlet private weak var textMessageOwnerLabel: UILabel!
    @IBOutlet private weak var textMessageSendDateLabel: UILabel!
    @IBOutlet private weak var attachmentsCountLabel: UILabel!
    
    // MARK: - Variables
    private lazy var attachmentsCollectionViewController: AttachmentsCollectionViewController = {
        let collectionViewController = AttachmentsCollectionViewController()
        return collectionViewController
    }()
    
    var attatchemtsCountLabelHeight: CGFloat {
        return attachmentsCountLabel.frame.size.height
    }
    var updatedCollectionViewHeight: ((CGFloat) -> Void)?

    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        addSubview(attachmentsCollectionViewController.collectionView)
        attachmentsCollectionViewController.collectionView.anchor(top: attachmentsCountLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 16, left: 16, bottom: 16, right: 16))
    }
}

// MARK: - AttachmentCollectionViewCellProtocol
extension AttachmentCollectionViewCell: AttachmentCollectionViewCellProtocol {
    
    func display(messageOwner: String) {
        textMessageOwnerLabel.text = messageOwner
    }
    
    func display(messageDate: String) {
        textMessageSendDateLabel.text = messageDate
    }
    
    func display(attachmentsTitle: String) {
        attachmentsCountLabel.text = attachmentsTitle
    }
    
    func display(attachments: [String], attachmentSelection: @escaping AttachmentSelection) {
        let view = attachmentsCollectionViewController as AttachmentsViewProtocol
        let interactor = AttachmentsInteractor()
        let router = AttachmentsRouter()
        let presenter = AttachmentsPresenter(view: view, interactor: interactor, router: router, attachments: attachments, attachmentSelection: attachmentSelection)
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = attachmentsCollectionViewController
        attachmentsCollectionViewController.presenter.viewDidLoad()
        attachmentsCollectionViewController.collectionView.reloadData()
        DispatchQueue.main.async { [weak self] in
            let height = self?.attachmentsCollectionViewController.collectionView.collectionViewLayout.collectionViewContentSize.height ?? 0.0
            self?.updatedCollectionViewHeight?(height)
        }
    }
}
