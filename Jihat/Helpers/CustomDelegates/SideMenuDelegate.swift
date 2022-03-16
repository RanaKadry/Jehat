//
//  SideMenuDelegate.swift
//  Jihat
//
//  Created by Peter Bassem on 24/09/2021.
//

import Foundation

class SideMenuDelegate: SideMenuNavigationViewControllerDelegate {
    
    private let showSideMenu: ActionCompletion
    private let hideSideMenu: ActionCompletion
    
    init(showSideMenu: @escaping ActionCompletion, hideSideMenu: @escaping ActionCompletion) {
        self.showSideMenu = showSideMenu
        self.hideSideMenu = hideSideMenu
    }
    
    func sideMenuAppears() {
        showSideMenu()
    }
    
    func sideMenuDisappears() {
        hideSideMenu()
    }
}
