//
//  AddNewDelegateProtocols.swift
//  Jihat
//
//  Created Ahmed Barghash on 02/10/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

// MARK: AddNewDelegate Protocols

protocol AddNewDelegateViewProtocol: BaseViewProtocol {
    var presenter: AddNewDelegatePresenterProtocol! { get set }
    
    func set(title: String)
    func set(englishName: String)
    func set(arabicName: String)
    func set(phone: String)
    func set(email: String)
    
    func enableSaveButton()
    func disableSaveButton()
    
    func startLoadingOnSaveButton()
    func stopLoadingOnSaveButton()
}

protocol AddNewDelegatePresenterProtocol: BasePresenterProtocol {
    var view: AddNewDelegateViewProtocol? { get set }
    
    func viewDidLoad()
    
    func performObserveInputs(arabicName: String?, englishName: String?, mobile: String?, mobileIsValid: Bool, email: String?)
    
    func performBack()
    func performShowCountriesList()
    
    func performAddDelegate(arabicName: String?, englishName: String?, mobile: String?, email: String?)

}

protocol AddNewDelegateRouterProtocol: BaseRouterProtocol {
    
}

protocol AddNewDelegateInteractorInputProtocol: BaseInteractorInputProtocol {
    var presenter: AddNewDelegateInteractorOutputProtocol? { get set }
    
    var userToken: String? { get }
    func getSingleDelegate(singleCommissionerRequest: EditDelegateRequest)
    func addDelegate(addCommisionerRequest: AddDelegateRequest)
    func updateDelegate(updateCommissionerRequest: UpdateDelegateRequest)
    
}

protocol AddNewDelegateInteractorOutputProtocol: BaseInteractorOutputProtocol {
    
    func fetchingAddDelegateSuccessfully(message: String)
    func fetchingSingleDelegateWihSuccess(delegate: CommissionersResponse)
    func fetchinWithError(error: String)
    
}
