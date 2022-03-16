//
//  SideMenuNavigationViewController.swift
//  Jihat
//
//  Created by Peter Bassem on 23/09/2021.
// 

import UIKit
import SideMenu

protocol SideMenuNavigationViewControllerDelegate: AnyObject {
    func sideMenuAppears()
    func sideMenuDisappears()
}

class SideMenuNavigationViewController: SideMenuNavigationController {
    
    // MARK: - Variables
    weak var sideMenuNavigationDelegate: SideMenuNavigationViewControllerDelegate?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setNavigationBarHidden(true, animated: true)
        
        setupSideMenu()
    }
    
    private func setupSideMenu() {
        presentationStyle = .menuSlideIn
        leftSide = !LocalizationHelper.isArabic()
        switch LocalizationHelper.isArabic() {
        case true: SideMenuManager.default.rightMenuNavigationController = self
        case false: SideMenuManager.default.leftMenuNavigationController = self
        }
        menuWidth = view.frame.size.width * 0.8
        sideMenuDelegate = self
    }
    
    class func addOpenSideMenuGesture(toView view: UIView) {
        SideMenuManager.default.addPanGestureToPresent(toView: view)
    }
    
    class func removeLeftMenuNavigationController() {
        SideMenuManager.default.leftMenuNavigationController = nil
    }
    
    class func removeRightMenuNavigationController() {
        SideMenuManager.default.rightMenuNavigationController = nil
    }
}

// MARK: - SideMenuNavigationControllerDelegate
extension SideMenuNavigationViewController: SideMenuNavigationControllerDelegate {
    
    func sideMenuWillAppear(menu: SideMenuNavigationController, animated: Bool) {
        sideMenuNavigationDelegate?.sideMenuAppears()
    }
    
    func sideMenuWillDisappear(menu: SideMenuNavigationController, animated: Bool) {
        sideMenuNavigationDelegate?.sideMenuDisappears()
    }
}
