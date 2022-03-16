//
//  OrderUpdatesTypePresenter.swift
//  Jihat
//
//  Created Peter Bassem on 30/09/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

enum OrderCommentType: String, CaseIterable {
    case text, voiceNote, attachment
}

import Foundation

// MARK: OrderUpdatesType Presenter -

class OrderUpdatesTypePresenter: BasePresenter {

    weak var view: OrderUpdatesTypeViewProtocol?
    private let interactor: OrderUpdatesTypeInteractorInputProtocol
    private let router: OrderUpdatesTypeRouterProtocol
    private var orderComments: [UserOrderCommentsResponse]
        
    private var addTextAction: ActionCompletion
    private var addVoiceNoteAction: ActionCompletion
    private var addAttachmentAction: ActionCompletion
    
    init(view: OrderUpdatesTypeViewProtocol, interactor: OrderUpdatesTypeInteractorInputProtocol, router: OrderUpdatesTypeRouterProtocol, orderComments: [UserOrderCommentsResponse], addTextAction: @escaping ActionCompletion, addVoiceNoteAction: @escaping ActionCompletion, addAttachmentAction: @escaping ActionCompletion) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.orderComments = orderComments
        self.addTextAction = addTextAction
        self.addVoiceNoteAction = addVoiceNoteAction
        self.addAttachmentAction = addAttachmentAction
    }
}

// MARK : - OrderUpdatesTypePresenterProtocol
extension OrderUpdatesTypePresenter: OrderUpdatesTypePresenterProtocol {
    
    func viewDidLoad() {
        view?.refreshScrollView()
        view?.refreshCollectionView()
    }
    
    func updateOrderComments(orderComments: [UserOrderCommentsResponse]?) {
        self.orderComments = orderComments ?? []
        view?.refreshScrollView()
        view?.refreshCollectionView()
//        view?.scrollToBottom()
    }
    
    func showOrderUpdates() {
        for (index, orderComment) in orderComments.enumerated() {
            if orderComment.attachment?.isEmpty == false && orderComment.attachment?.count == 1 && ((orderComment.attachment?.contains(".m4a")) != nil) {
                view?.changeButtonImage(atIndex: index, play: true)
            }
        }
    }
}

// MARK : - API
extension OrderUpdatesTypePresenter: OrderUpdatesTypeInteractorOutputProtocol {
    
    func fetchingDownloadedDocumentWithSuccess(localFileUrl: URL) {
        router.presentDocumentPreveiwViewController(fileurl: localFileUrl)
    }
}

// MARK : - Selectors
extension OrderUpdatesTypePresenter {
    
    private func stopCurrentlyPlaying() {
        if let currentVoiceNoteURL = Player.shared.currentlyPlaying() {
            Player.shared.stop()
            orderComments.forEach {
                if $0.attachment?.isEmpty == false { // && $0.attachment?.count == 1
                    if let indexStop = orderComments.firstIndex(where: { $0.attachment?.first == currentVoiceNoteURL.absoluteString }) {
                        view?.changeButtonImage(atIndex: indexStop, play: true)
                    }
                }
            }
        }
    }
    
    func performVoiceNoteButtonPressed(atIndex index: Int) {
        guard let voiceNoteURL = URL(string: orderComments[index].attachment?[0] ?? "") else { print("no vn located!!!!!!"); return }
        guard voiceNoteURL != Player.shared.currentlyPlaying() else {
            stopCurrentlyPlaying()
            return
        }
        stopCurrentlyPlaying()
        Player.shared.play(this: voiceNoteURL)
        view?.changeButtonImage(atIndex: index, play: false)
        
        Player.shared.audioCompletion = { [weak self] in
            self?.stopCurrentlyPlaying()
        }
    }
    
    func performAddText() {
        addTextAction()
    }
    
    func performAddVoiceNote() {
        addVoiceNoteAction()
    }
    
    func performAddAttachment() {
        addAttachmentAction()
    }
}

// MARK : - CollectionView Setup
extension OrderUpdatesTypePresenter {
    
    var itemsCount: Int {
        return orderComments.count
    }
    
    func commentType(atIndex index: Int) -> OrderCommentType {
        var isAttachment = false
        if orderComments[index].attachment?.isEmpty == true {
            return .text
        } else {
            (orderComments[index].attachment ?? [""]).forEach {
                if $0.lowercased().contains("txt") || $0.lowercased().contains("doc") || $0.lowercased().contains("xls") || $0.lowercased().contains("ppt") || $0.lowercased().contains("jpg") || $0.lowercased().contains("jpeg") {
                    isAttachment = true
                } else {
                    isAttachment = false
                }
            }
            return isAttachment ? .attachment : .voiceNote
        }
    }
    
    func configureTextMessageCell(_ cell: TextMessageCollectionViewCellProtocol, atIndex index: Int) {
        cell.display(messageOwner: orderComments[index].by ?? "")
        let dateString = String(String(orderComments[index].date?.split(separator: "-").last ?? "").split(separator: " ").first ?? "")
        cell.display(messageDate: Date.localizedDate(date: dateString))
        cell.display(messageText: orderComments[index].content ?? "")
    }
    
    func textMessage(atIndex index: Int) -> String {
        return orderComments[index].content ?? ""
    }
    
    func configureVoiceNoteCell(_ cell: VoiceNoteCollectionViewCellProtocol, atIndex index: Int) {
        cell.display(messageOwner: orderComments[index].by ?? "")
        let dateString = String(String(orderComments[index].date?.split(separator: "-").last ?? "").split(separator: " ").first ?? "")
        cell.display(messageDate: Date.localizedDate(date: dateString))
        cell.display(messageText: orderComments[index].content ?? "")
    }
    
    func configureAttachmentCell(_ cell: AttachmentCollectionViewCellProtocol, atIndex index: Int) {
        cell.display(messageOwner: orderComments[index].by ?? "")
        let dateString = String(String(orderComments[index].date?.split(separator: "-").last ?? "").split(separator: " ").first ?? "")
        cell.display(messageDate: Date.localizedDate(date: dateString))
        cell.display(attachmentsTitle: orderComments[index].content ?? "")
        cell.display(attachments: orderComments[index].attachment ?? [""]) { [weak self] url in
            self?.interactor.downloadDocument(fileurl: url)
        }
    }
}
