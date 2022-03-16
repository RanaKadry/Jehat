//
//  RegisterInteractor.swift
//  Jihat
//
//  Created Peter Bassem on 17/09/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

// MARK: Register Interactor -

class RegisterInteractor: RegisterInteractorInputProtocol {
    
    weak var presenter: RegisterInteractorOutputProtocol?
    private let useCase: RegisterUseCase
    
    init(useCase: RegisterUseCase) {
        self.useCase = useCase
    }
    
    func getUserCountries() {
        useCase.getUserCountries { result in
            switch result {
            case .success(let countriesResponse):
                if countriesResponse.status == true {
                    guard let countries = countriesResponse.data, !countries.isEmpty else { return }
                    DispatchQueue.main.async { [weak self] in
                        self?.presenter?.fetchingCountriesSuccessfully(countries: countries)
                    }
                } else {
                    DispatchQueue.main.async { [weak self] in
                        self?.presenter?.fetchingWithError(error: countriesResponse.message ?? "")
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async { [weak self] in
                    self?.presenter?.fetchingWithError(error: error.rawValue.localized())
                }
            }
        }
    }
    
    func registerUser(registerRequest: RegisterRequest) {
        useCase.registerUser(registerRequest: registerRequest) { result in
            switch result {
            case .success(let registerResponse):
                if registerResponse.status == true {
                    guard let register = registerResponse.data else { return }
                    DispatchQueue.main.async { [weak self] in
                        self?.presenter?.fetchingRegisterUserMessageSuccessfully(successMessage: registerResponse.message ?? "")
                        self?.presenter?.fetchingRegisterUserSuccessfully(registerResponse: register)
                    }
                } else {
                    DispatchQueue.main.async { [weak self] in
                        self?.presenter?.fetchingWithError(error: registerResponse.message ?? "")
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async { [weak self] in
                    self?.presenter?.fetchingWithError(error: error.rawValue.localized())
                }
            }
        }
    }
    
    func saveUser(id: String?) {
        useCase.saveUserId(id: id)
    }
    
    func update(userVerified: Bool) {
        useCase.update(userVerified: userVerified)
    }
}
