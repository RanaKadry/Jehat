//
//  AppDelegate.swift
//  Jihat
//
//  Created by Peter Bassem on 13/09/2021.
//

import UIKit

@main
class AppDelegate: UIResponder , UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        setupIQKeyboard()
        if #available(iOS 13.0, *) { } else {
            self.window = MainAppInteractor.setRoot(UIWindow(frame: UIScreen.main.bounds))
        }
        UITextField.appearance().tintColor = DesignSystem.Colors.primaryBorderColor.color
        UITextView.appearance().tintColor = DesignSystem.Colors.primaryBorderColor.color
        print(PersistentDataHelper.shared.token)
        return true
    }
    
    // MARK: UISceneSession Lifecycle

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}

// MARK: - Reset Language
extension AppDelegate {
    
    func setRoot() {
        self.window = MainAppInteractor.setRoot()
    }
}
