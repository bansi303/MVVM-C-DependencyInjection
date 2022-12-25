//
//  UsersCoordinator.swift
//  MVVM+DependencyInjection
//
//  Created by Bansi Hirpara on 2022-07-05.
//

import Foundation
import UIKit

class UsersCoordinaor: Coordinator {
    var parentCoordinator: Coordinator?
    
    var children: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    let storyboard =  UIStoryboard.init(name: "Main", bundle: .main)
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        print("User coordinator start")
        let usersViewController = storyboard.instantiateViewController(withIdentifier: "UsersViewController") as! UsersViewController
        let userViewModel = UserViewModel.init(userService: UserServiceObject())
        userViewModel.appCoordinator = self
        usersViewController.viewModel = userViewModel
        navigationController.pushViewController(usersViewController, animated: true)
    }
}
