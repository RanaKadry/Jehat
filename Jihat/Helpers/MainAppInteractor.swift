//
//  MainAppInteractor.swift
//  Jihat
//
//  Created by Peter Bassem on 20/10/2021.
//

import Foundation
import UIKit

class MainAppInteractor {
    
    private static var mWindow: UIWindow!
    
    static func setRoot(_ window: UIWindow? = nil) -> UIWindow? {
        if let window = window {
            self.mWindow = window
        }
        let userRepo = UserRepositoryImp()
        if userRepo.isUserVerified {
            mWindow.rootViewController = PhoneVerificationRouter.createModule()
        } else {
            if userRepo.isUserLoggedIn {
                mWindow.rootViewController = UINavigationController(rootViewController: HomeRouter.createModule())
            } else {
                mWindow.rootViewController = UINavigationController(rootViewController: LoginRouter.createModule())
            }
        }
        
//        mWindow.rootViewController = VoteRequiredRouter.createModule()  // UINavigationController(rootViewController: HomeRouter.createModule())
        mWindow.makeKeyAndVisible()
        return mWindow
    }
}
