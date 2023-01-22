//
//  SwinjectStoryboard+Extention.swift
//  MVVM+DependencyInjection
//
//  Created by Bansi Hirpara on 2023-01-21.
//

import UIKit
import Swinject
import SwinjectStoryboard

extension SwinjectStoryboard {
    public static func setup() {
        if AppDelegate.dependencyRegistry == nil {
            AppDelegate.dependencyRegistry = DependencyRegisterImp(container: defaultContainer)
        }
        
        let dependencyRegistry: DependencyRegister = AppDelegate.dependencyRegistry
        
        func main() {
            dependencyRegistry.container.storyboardInitCompleted(UsersViewController.self) { r, vc in
                let appCordinator = dependencyRegistry.makeAppCordination(vc: vc)
                AppDelegate.appCoordinator = appCordinator
                
                let userCordinator = dependencyRegistry.makeUserCordination(vc: vc)
                
                let viewModal = r.resolve(UserViewModel.self)!
                vc.configure(with: viewModal, tableViewCellMake: dependencyRegistry.makeUserTableViewCell, usersCoordinator: userCordinator)
            }
        }
        
        main()
    }
}
