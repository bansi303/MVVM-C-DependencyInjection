//
//  UsersCoordinator.swift
//  MVVM+DependencyInjection
//
//  Created by Bansi Hirpara on 2022-07-05.
//

import Foundation
import UIKit

class UsersCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    
    var children: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    let storyboard =  UIStoryboard.init(name: "Main", bundle: .main)
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
//        print("User coordinator start")
//        var usersViewController = storyboard.instantiateViewController(withIdentifier: "UsersViewController") as! UsersViewController
//        usersViewController.appCoordinator = self
//        let dataProvider = DataProviderImp(userService: UserServiceObject())
//        let userViewModel = UserViewModel.init(dataProvider: dataProvider)
//        usersViewController.viewModel = userViewModel
//        navigationController.pushViewController(usersViewController, animated: true)
    }
    
    func goToUserDetailsViewController(userData: UserModel) {
        let vc = storyboard.instantiateViewController(withIdentifier: "UserDetailViewController") as! UserDetailViewController
//        vc.configure(with: userData)
        navigationController.pushViewController(vc, animated: true)
    }
}
