//
//  SideMenuPresenter.swift
//  Jihat
//
//  Created Peter Bassem on 22/09/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

// MARK: SideMenu Presenter -

class SideMenuPresenter: BasePresenter  {

    weak var view: SideMenuViewProtocol?
    private let interactor: SideMenuInteractorInputProtocol
    private let router: SideMenuRouterProtocol
    private let user: UserDataResponse
    
    private var profileButtonPressed: ActionCompletion
    private var didSelectItem: SideMenuSelectionItem
    
    init(view: SideMenuViewProtocol, interactor: SideMenuInteractorInputProtocol, router: SideMenuRouterProtocol, user: UserDataResponse, profileButtonPressed: @escaping ActionCompletion, didSelectItem: @escaping SideMenuSelectionItem) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.user = user
        self.profileButtonPressed = profileButtonPressed
        self.didSelectItem = didSelectItem
    }
}

// MARK: - SideMenuPresenterProtocol
extension SideMenuPresenter: SideMenuPresenterProtocol {
    
    func viewDidLoad() {
        
    }
    
    private func setCell(_ cell: SidemenuItemCollectionViewCellProtocol, imageName: String, titleKey: String) {
        cell.displayItem(imageName: imageName)
        cell.displayItem(title: titleKey.localized())
    }
}

// MARK: - API
extension SideMenuPresenter: SideMenuInteractorOutputProtocol {
    
}

// MARK: - Selectors
extension SideMenuPresenter {
    
    func performChangeLanguage() {
        switch LocalizationHelper.getCurrentLanguage() {
        case "en":
            guard LocalizationHelper.getCurrentLanguage() == "en" else {
                print("Same Language")
                return
            }
            LocalizationHelper.setCurrentLang(lang: "ar")
            IQKeyboardManagerHelper.setDoneTitle()
        case "ar":
            guard LocalizationHelper.getCurrentLanguage() == "ar" else {
                print("Same Language")
                return
            }
            LocalizationHelper.setCurrentLang(lang: "en")
            IQKeyboardManagerHelper.setDoneTitle()
        default: break
        }
    }
    
    func performShowProfile() {
        profileButtonPressed()
    }
}

// MARK: - CollectionView Setup
extension SideMenuPresenter {
    
    func configureSidemenuHeader(_ header: SidemenuHeaderCollectionViewCellProtocol) {
        header.displayDesiredLanguage(language: LocalizationHelper.isArabic() ? "language.english".localized() : "language.arabic".localized())
        header.display(username: LocalizationHelper.isArabic() ? (user.arabicName ?? "") : (user.englishName ?? ""))
        interactor.userToken == nil ? header.hideEditProfileButton() : header.showEditProfileButton()
    }
    
    var sidemenuItems: Int {
        if interactor.userToken == nil {
            return SideMenuItems.allCases.count - 1
        } else {
            return SideMenuItems.allCases.count
        }
    }
    
    func configureSidemenuItemCell(_ cell: SidemenuItemCollectionViewCellProtocol, atIndex index: Int) {
        switch SideMenuItems.allCases[index] {
        case .addOrder: setCell(cell, imageName: "sidemenu.add_order", titleKey: "add_order".localized())
        case .myOrders: setCell(cell, imageName: "sidemenu.my_orders", titleKey: "my_orders".localized())
        case .myMeetings: setCell(cell, imageName: "sidemenu.my_meetings", titleKey: "my_meetings".localized())
        case .myCalendar: setCell(cell, imageName: "sidemenu.my_calendar", titleKey: "my_calendar".localized())
        case .listDelegates: setCell(cell, imageName: "sidemenu.delegats_list", titleKey: "delegates_list".localized())
        case .documents: setCell(cell, imageName: "sidemenu.documents", titleKey: "documents".localized())
        case .contactUs: setCell(cell, imageName: "contact_us", titleKey: "contact_us".localized())
        case .logout: setCell(cell, imageName: "sidemenu.logout", titleKey: "logout".localized())
        }
    }
    
    func didSelectMenuItem(atIndex index: Int) {
        let selectedMenuItem = SideMenuItems.allCases[index]
        didSelectItem(selectedMenuItem)
    }
}
