//
//  AppDelegate.swift
//  MVVM+DependencyInjection
//
//  Created by Bansi Hirpara on 2022-06-04.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    static var usersCoordinator: UsersCoordinator?
    static var dependencyRegistry: DependencyRegister!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
//        window = UIWindow(frame: UIScreen.main.bounds)
        
//        let navController = UINavigationController.init()
//        appCoordinator = AppCordinator.init(navigationController: navController)
//        appCoordinator!.start()
        
//        window!.rootViewController = navController
//        window!.makeKeyAndVisible()
        
        return true
    }
}

