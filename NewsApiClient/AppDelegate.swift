//
//  AppDelegate.swift
//  NewsApiClient
//
//  Created by user on 17/06/2021.
//  Copyright © 2021 Artem Ulko. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let rootTabBarController = RootTabBarController()
        window!.rootViewController = rootTabBarController
        window!.makeKeyAndVisible()
        
        return true
    }
}
