//
//  SideMenuProtocols.swift
//  Jihat
//
//  Created Peter Bassem on 22/09/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

// MARK: SideMenu Protocols

protocol SideMenuViewProtocol: BaseViewProtocol {
    var presenter: SideMenuPresenterProtocol! { get set }
    
}

protocol SideMenuPresenterProtocol: BasePresenterProtocol {
    var view: SideMenuViewProtocol? { get set }
    
    func viewDidLoad()

    var sidemenuItems: Int { get }
    func configureSidemenuHeader(_ header: SidemenuHeaderCollectionViewCellProtocol)
    func configureSidemenuItemCell(_ cell: SidemenuItemCollectionViewCellProtocol, atIndex index: Int)
    func didSelectMenuItem(atIndex index: Int)

    func performChangeLanguage()
    func performShowProfile()
}

protocol SideMenuRouterProtocol: BaseRouterProtocol {
    
}

protocol SideMenuInteractorInputProtocol: BaseInteractorInputProtocol {
    var presenter: SideMenuInteractorOutputProtocol? { get set }
    var userToken: String? { get }
}

protocol SideMenuInteractorOutputProtocol: BaseInteractorOutputProtocol {
    
}
