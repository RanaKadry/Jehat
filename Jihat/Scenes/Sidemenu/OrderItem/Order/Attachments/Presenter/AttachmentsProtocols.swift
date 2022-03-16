//
//  AttachmentsProtocols.swift
//  Jihat
//
//  Created Peter Bassem on 09/10/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

// MARK: Attachments Protocols

protocol AttachmentsViewProtocol: BaseViewProtocol {
    var presenter: AttachmentsPresenterProtocol! { get set }
    
    func configureCollectionView()
}

protocol AttachmentsPresenterProtocol: BasePresenterProtocol {
    var view: AttachmentsViewProtocol? { get set }
    
    func viewDidLoad()

    var attatchmentsCount: Int { get }
    func configureAttatchemtCell(_ cell: AttatchmentCollectionViewCellProtocol, atIndex index: Int)
    func didSelectAttachment(atIndex index: Int)
}

protocol AttachmentsRouterProtocol: BaseRouterProtocol {
    
}

protocol AttachmentsInteractorInputProtocol: BaseInteractorInputProtocol {
    var presenter: AttachmentsInteractorOutputProtocol? { get set }
    
}

protocol AttachmentsInteractorOutputProtocol: BaseInteractorOutputProtocol {
    
    
}
