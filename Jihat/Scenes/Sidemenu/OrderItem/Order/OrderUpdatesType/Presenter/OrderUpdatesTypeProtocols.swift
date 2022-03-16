//
//  OrderUpdatesTypeProtocols.swift
//  Jihat
//
//  Created Peter Bassem on 30/09/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

// MARK: OrderUpdatesType Protocols

protocol OrderUpdatesTypeViewProtocol: BaseViewProtocol {
    var presenter: OrderUpdatesTypePresenterProtocol! { get set }
    
    func refreshScrollView()
    func refreshCollectionView()
    func changeButtonImage(atIndex index: Int, play: Bool)
    func scrollToBottom()
}

protocol OrderUpdatesTypePresenterProtocol: BasePresenterProtocol {
    var view: OrderUpdatesTypeViewProtocol? { get set }
    
    func viewDidLoad()
    func updateOrderComments(orderComments: [UserOrderCommentsResponse]?)
    func showOrderUpdates()
    
    var itemsCount: Int { get }
    func commentType(atIndex index: Int) -> OrderCommentType
    func configureTextMessageCell(_ cell: TextMessageCollectionViewCellProtocol, atIndex index: Int)
    func textMessage(atIndex index: Int) -> String
    func configureVoiceNoteCell(_ cell: VoiceNoteCollectionViewCellProtocol, atIndex index: Int)
    func configureAttachmentCell(_ cell: AttachmentCollectionViewCellProtocol, atIndex index: Int)
    
    func performVoiceNoteButtonPressed(atIndex index: Int)
    func performAddText()
    func performAddVoiceNote()
    func performAddAttachment()
}

protocol OrderUpdatesTypeRouterProtocol: BaseRouterProtocol {
    
}

protocol OrderUpdatesTypeInteractorInputProtocol: BaseInteractorInputProtocol {
    var presenter: OrderUpdatesTypeInteractorOutputProtocol? { get set }
    
    var userToken: String? { get }
    func downloadDocument(fileurl: URL)
}

protocol OrderUpdatesTypeInteractorOutputProtocol: BaseInteractorOutputProtocol {
    func fetchingDownloadedDocumentWithSuccess(localFileUrl: URL)
}
