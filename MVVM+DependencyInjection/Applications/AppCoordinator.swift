//
//  AppCoordinator.swift
//  MVVM+DependencyInjection
//
//  Created by Bansi Hirpara on 2022-07-05.
//

import Foundation
import UIKit

class AppCordinator: Coordinator {
    var parentCoordinator: Coordinator?
    
    var children: [Coordinator] = []
    
    var rootViewController: UIViewController
    
    var dependencyRegister: DependencyRegister
    
    init(rootViewController: UIViewController, dependencyRegister: DependencyRegister) {
        self.rootViewController = rootViewController
        self.dependencyRegister = dependencyRegister
    }
    
    func start() {
        print("App coordinator start")
        goToUser()
    }
    
    func goToUser() {
        let userCoordinator = dependencyRegister.makeUserCordination(vc: rootViewController)
        userCoordinator.parentCoordinator = self
        children.append(userCoordinator)
        userCoordinator.start()
    }
    
    deinit {
        
    }
}
