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
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        print("App coordinator start")
        goToUser()
    }
    
    func goToUser() {
        let userCoordinator = UsersCoordinaor.init(navigationController: navigationController)
        userCoordinator.parentCoordinator = self
        children.append(userCoordinator)
        
        userCoordinator.start()
    }
    
    deinit {
        
    }
}
