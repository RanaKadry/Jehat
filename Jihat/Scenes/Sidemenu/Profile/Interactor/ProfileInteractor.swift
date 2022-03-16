//
//  ProfileInteractor.swift
//  Jihat
//
//  Created Ahmed Barghash on 25/09/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

// MARK: Profile Interactor -

class ProfileInteractor: ProfileInteractorInputProtocol {
    
    weak var presenter: ProfileInteractorOutputProtocol?
    private var useCase: ProfileUseCase
    
    private var user: UserDataResponse?
    private var countires: [CountriesModel]?
    private var error: String?
    
    init(useCase: ProfileUseCase) {
        self.useCase = useCase
    }
    
    var userToken: String? {
        return useCase.userToken
    }
    
    var userId: String? {
        return useCase.userId
    }
    
    private func getUser(userRequest: BaseRequest, successCompletion: @escaping (UserDataResponse) -> Void, failCompletion: @escaping (String) -> Void) {
        useCase.getUser(userDataRequest: userRequest) { result in
            switch result {
            case .success(let userResponse):
                if userResponse.status == true {
                    guard let user = userResponse.data else { return }
                    successCompletion(user)
                } else {
                    failCompletion(userResponse.message ?? "")
                }
            case .failure(let error):
                failCompletion(error.rawValue.localized())
            }
        }
    }
    
    private func getUserCountries(successCompletion: @escaping ([CountriesModel]) -> Void, failCompletion: @escaping (String) -> Void) {
        useCase.getUserCountries { result in
            switch result {
            case .success(let countriesResponse):
                if countriesResponse.status == true {
                    guard let countries = countriesResponse.data, !countries.isEmpty else { return }
                    successCompletion(countries)
                } else {
                    failCompletion(countriesResponse.message ?? "")
                }
            case .failure(let error):
                failCompletion(error.rawValue.localized())
            }
        }
    }
    
    func getProfileData(profileRequest: BaseRequest) {
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        getUser(userRequest: profileRequest) { [weak self] user in
            dispatchGroup.leave()
            self?.user = user
        } failCompletion: { [weak self] error in
            dispatchGroup.leave()
            self?.error = error
        }
        
        dispatchGroup.enter()
        getUserCountries { [weak self] countires in
            dispatchGroup.leave()
            self?.countires = countires
        } failCompletion: { [weak self] error in
            dispatchGroup.leave()
            self?.error = error
        }


        dispatchGroup.notify(queue: .main) { [weak self] in
            if let error = self?.error {
                self?.presenter?.fetchingWithError(error: error)
                return
            }
            if self?.user != nil && self?.countires != nil {
                self?.presenter?.hideSuccessLoading()
            }
            if let user = self?.user {
                self?.presenter?.fetchingUserWithSuccess(user: user)
            }
            if let countires = self?.countires {
                self?.presenter?.fetchingCountriesSuccessfully(countries: countires)
            }
        }
    }
    
    func updateUserData(updateUserDataRequest: UpdateUserDataRequest) {
        useCase.updateUser(updateUserDataRequest: updateUserDataRequest) { [weak self] result in
            switch result {
            case .success(let updateUserDataResponse):
                if updateUserDataResponse.status == true {
                    DispatchQueue.main.async {
                        self?.presenter?.fetchingUpdateUserDataWithsuccess(message: updateUserDataResponse.message ?? "")
                    }
                } else {
                    DispatchQueue.main.async {
                        self?.presenter?.fetchingWithError(error: updateUserDataResponse.message ?? "")
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.presenter?.fetchingWithError(error: error.rawValue.localized())
                }
            }
        }
    }
}
