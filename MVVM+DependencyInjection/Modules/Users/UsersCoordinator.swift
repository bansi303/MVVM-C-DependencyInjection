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
    
    var rootViewController: UIViewController
    
    let storyboard =  UIStoryboard.init(name: "Main", bundle: .main)
    
    var dependencyRegister: DependencyRegister
    
    init(rootViewController: UIViewController, dependencyRegister: DependencyRegister) {
        self.rootViewController = rootViewController
        self.dependencyRegister = dependencyRegister
    }
    
    func start() {

    }
    
    func goToUserDetailsViewController(userData: UserModel) {
        let userDetailVC = dependencyRegister.makeUserDetailViewController(with: userData)
        rootViewController.navigationController?.pushViewController(userDetailVC, animated: true)
    }
}
