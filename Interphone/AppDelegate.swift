//
//  AppDelegate.swift
//  ios-template-app
//
//  Created by OpenYourEyes on 05/01/2021.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        LibsManager.shared.setupLibs()
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        Application.shared.presentInitialScreen(in: window)
        window.makeKeyAndVisible()
        return true
    }

}

