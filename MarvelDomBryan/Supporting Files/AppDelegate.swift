//
//  AppDelegate.swift
//  MarvelDomBryan
//
//  Created by Dom Bryan on 22/02/2020.
//  Copyright © 2020 Dom Bryan. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coordinator: RootCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
//        let navigationViewController = UINavigationController()
//        coordinator = RootCoordinator(navigationController: navigationViewController)
//        coordinator?.start()
//        
//        window = UIWindow(frame: UIScreen.main.bounds)
//        window?.rootViewController = coordinator?.navigationController
//        window?.makeKeyAndVisible()
//        
        return true
    }
}

