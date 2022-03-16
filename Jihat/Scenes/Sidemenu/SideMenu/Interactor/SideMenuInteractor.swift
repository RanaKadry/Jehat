//
//  SideMenuInteractor.swift
//  Jihat
//
//  Created Peter Bassem on 22/09/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

// MARK: SideMenu Interactor -

class SideMenuInteractor: SideMenuInteractorInputProtocol {
    
    weak var presenter: SideMenuInteractorOutputProtocol?
    private let useCase: SideMenuUseCase
    
    init(useCase: SideMenuUseCase) {
        self.useCase = useCase
    }
    
    var userToken: String? {
        return useCase.userToken
    }
}
