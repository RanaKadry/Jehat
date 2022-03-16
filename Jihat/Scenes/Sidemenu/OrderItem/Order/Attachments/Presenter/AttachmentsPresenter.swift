//
//  AttachmentsPresenter.swift
//  Jihat
//
//  Created Peter Bassem on 09/10/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

// MARK: Attachments Presenter -

class AttachmentsPresenter: BasePresenter {

    weak var view: AttachmentsViewProtocol?
    private let interactor: AttachmentsInteractorInputProtocol
    private let router: AttachmentsRouterProtocol
    private let attachments: [String]
    private let attachmentSelection: AttachmentSelection
    
    init(view: AttachmentsViewProtocol, interactor: AttachmentsInteractorInputProtocol, router: AttachmentsRouterProtocol, attachments: [String], attachmentSelection: @escaping AttachmentSelection) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.attachments = attachments
        self.attachmentSelection = attachmentSelection
    }
}

// MARK: - AttachmentsPresenterProtocol
extension AttachmentsPresenter: AttachmentsPresenterProtocol {
    
    func viewDidLoad() {
        view?.configureCollectionView()
    }
}

// MARK: - API
extension AttachmentsPresenter: AttachmentsInteractorOutputProtocol {
    
}

// MARK: - AttatchmentsCollectionView Setup
extension AttachmentsPresenter {
    
    var attatchmentsCount: Int {
        return attachments.count
    }
    
    func configureAttatchemtCell(_ cell: AttatchmentCollectionViewCellProtocol, atIndex index: Int) {
//        cell.setImage(DesignSystem.Icon.attachemtPlaceholder.rawValue)
        
        let attachment = attachments[index]
        if attachment.contains("jpeg") || attachment.contains("jpg") {
            cell.setImage(attachment)
        } else {
            if attachment.contains("pdf") {
                cell.setImage(image: DesignSystem.Icon.pdf.image)
            } else if attachment.contains("doc") {
                cell.setImage(image: DesignSystem.Icon.word.image)
            } else if attachment.contains("xls") {
                cell.setImage(image: DesignSystem.Icon.excel.image)
            } else if attachment.contains("ppt") {
                cell.setImage(image: DesignSystem.Icon.powerpoint.image)
            } else if attachment.contains("txt") {
                cell.setImage(image: DesignSystem.Icon.txt.image)
            }
        }
    }
    
    func didSelectAttachment(atIndex index: Int) {
        guard let url = URL(string: attachments[index] ?? "") else { return }
        attachmentSelection(url)
    }
}
