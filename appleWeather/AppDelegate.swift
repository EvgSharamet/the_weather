//
//  AppDelegate.swift
//  appleWeather
//
//  Created by Евгения Шарамет on 14.01.2022.
//

import UIKit

@main

class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = MainNavigationController()
        window.makeKeyAndVisible()
        self.window = window
        return true
    }
}
