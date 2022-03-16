//
//  AddNewDelegatePresenter.swift
//  Jihat
//
//  Created Ahmed Barghash on 02/10/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

// MARK: AddNewDelegate Presenter -

class AddNewDelegatePresenter: BasePresenter {

    weak var view: AddNewDelegateViewProtocol?
    private let interactor: AddNewDelegateInteractorInputProtocol
    private let router: AddNewDelegateRouterProtocol
    private let type: DelegateOperationsType
    private let newDelegateAdded: ActionCompletion?
    
    private var arabicName: String?
    private var englishName: String?
    private var mobile: String?
    private var email: String?
    
    init(view: AddNewDelegateViewProtocol, interactor: AddNewDelegateInteractorInputProtocol, router: AddNewDelegateRouterProtocol, type: DelegateOperationsType, newDelegateAdded: ActionCompletion? = nil) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.type = type
        self.newDelegateAdded = newDelegateAdded
    }
    
}

// MARK: - AddNewDelegatePresenterProtocol
extension AddNewDelegatePresenter: AddNewDelegatePresenterProtocol {
    
    func viewDidLoad() {
        switch type {
        case .add:
            view?.set(title: "add_new_delegate")
        case .update(let delegateId):
            view?.set(title: "edit_delegate")
            view?.showLoading()
            interactor.getSingleDelegate(singleCommissionerRequest: EditDelegateRequest(userToken: interactor.userToken, delegateId: delegateId))
        }
    }
    
    func performObserveInputs(arabicName: String?, englishName: String?, mobile: String?, mobileIsValid: Bool, email: String?) {
        
        switch type {
        case .add:
            let observeInputs = arabicName?.isEmpty == false && englishName?.isEmpty == false && mobile?.isEmpty == false && mobileIsValid && email?.isEmpty == false && email?.isValidEmail() == true
            observeInputs ? view?.enableSaveButton() : view?.disableSaveButton()
        case .update(_):
            var observeInputs: Bool
            if arabicName?.isEmpty == false && englishName?.isEmpty == false && mobileIsValid && email?.isValidEmail() == true {
                observeInputs = (arabicName?.isEmpty == false && self.arabicName?.removeLeadingAndTrailingSpaces() != arabicName?.removeLeadingAndTrailingSpaces()) || (englishName?.isEmpty == false && self.englishName?.removeLeadingAndTrailingSpaces() != englishName?.removeLeadingAndTrailingSpaces()) || (mobile?.isEmpty == false && (self.mobile?.removeLeadingAndTrailingSpaces() != mobile?.removeLeadingAndTrailingSpaces()) && mobileIsValid) || (email?.isEmpty == false && self.email?.removeLeadingAndTrailingSpaces() != email?.removeLeadingAndTrailingSpaces() && email?.isValidEmail() == true)
            } else {
                observeInputs = false
            }
            observeInputs ? view?.enableSaveButton() : view?.disableSaveButton()
        }
    }
    
}

// MARK: - API
extension AddNewDelegatePresenter: AddNewDelegateInteractorOutputProtocol {
    
    func fetchingAddDelegateSuccessfully(message: String) {
        view?.hideLoading()
        view?.stopLoadingOnSaveButton()
        view?.showBottomMessage(message)
        newDelegateAdded?()
        router.popupViewController()
    }
    
    func fetchingSingleDelegateWihSuccess(delegate: CommissionersResponse) {
        arabicName = delegate.arabicName
        englishName = delegate.englishName
        mobile = delegate.phone
        email = delegate.email
        view?.hideLoading()
        view?.set(arabicName: delegate.arabicName ?? "")
        view?.set(englishName: delegate.englishName ?? "")
        view?.set(phone: delegate.phone ?? "")
        view?.set(email: delegate.email ?? "")
    }
    
    func fetchinWithError(error: String){
        view?.hideLoading()
        view?.stopLoadingOnSaveButton()
        view?.showBottomMessage(error)
    }
    
}

// MARK: - Selectors
extension AddNewDelegatePresenter {
    
    func performBack() {
        router.popupViewController()
    }
    
    func performShowCountriesList() {
        router.showCountriesList()
    }
    
    
    func performAddDelegate(arabicName: String?, englishName: String?, mobile: String?, email: String?) {
        switch type {
        case .add:
            view?.startLoadingOnSaveButton()
            interactor.addDelegate(addCommisionerRequest: AddDelegateRequest(userToken: interactor.userToken, arabicName: arabicName, englishName: englishName, email: email, phone: mobile))
        case .update(let delegateId):
            view?.startLoadingOnSaveButton()
            interactor.updateDelegate(updateCommissionerRequest: UpdateDelegateRequest(userToken: interactor.userToken, delegateId: delegateId, arabicName: arabicName, englishName: englishName, email: email, phone: mobile))
        }
    }
    
}

