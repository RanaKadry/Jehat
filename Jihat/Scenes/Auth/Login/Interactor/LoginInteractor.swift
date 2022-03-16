//
//  LoginInteractor.swift
//  Jihat
//
//  Created Peter Bassem on 15/09/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

// MARK: Login Interactor -

class LoginInteractor: LoginInteractorInputProtocol {
    
    weak var presenter: LoginInteractorOutputProtocol?
    private let useCase: LoginUseCase
    
    init(useCase: LoginUseCase) {
        self.useCase = useCase
    }
    
    func getSponsers() {
        useCase.getSponsers { result in
            switch result {
            case .success(let sponsersResponse):
                if sponsersResponse.status == true {
                    guard let sponsers = sponsersResponse.data, !sponsers.isEmpty else { return }
                    DispatchQueue.main.async { [weak self] in
                        self?.presenter?.fetchingSponsersSuccessfully(sponsers: sponsers)
                    }
                } else {
                    DispatchQueue.main.async { [weak self] in
                        self?.presenter?.fetchingWithError(error: sponsersResponse.message ?? "")
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async { [weak self] in
                    self?.presenter?.fetchingWithError(error: error.localizedDescription.localized())
                }
            }
        }
    }
    
    func loginUser(withLoginRequest loginRequest: LoginRequest) {
        useCase.login(withLoginRequest: loginRequest) { result in
            switch result {
            case .success(let loginResponse):
                if loginResponse.status == true {
                    DispatchQueue.main.async { [weak self] in
                        guard let login = loginResponse.data else { return }
                        self?.presenter?.fetchingLoginSuccessfully(login: login)
                    }
                } else {
                    DispatchQueue.main.async { [weak self] in
                        self?.presenter?.fetchingWithError(error: loginResponse.message ?? "")
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async { [weak self] in
                    self?.presenter?.fetchingWithError(error: error.localizedDescription.localized())
                }
            }
        }
    }
    
    func saveUser(token: String?) {
        useCase.saveUserToken(token: token)
    }
    
    func saveUser(id: String?) {
        useCase.saveUserId(id: id)
    }
}
