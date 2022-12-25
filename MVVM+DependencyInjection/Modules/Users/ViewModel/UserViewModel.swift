//
//  UserViewModel.swift
//  MVVM+DependencyInjection
//
//  Created by Bansi Hirpara on 2022-07-05.
//

import Foundation

class UserViewModel {
    weak var appCoordinator: UsersCoordinaor!
    var userService: UserService!
    var userList: [UserModel]?
    
    init(userService: UserService) {
        self.userService = userService
    }
    
    func getUsers(completionHnadler: @escaping (Bool, String?)->()) {
        userService.getAllUsers() { userData, error in
            if userData != nil {
                self.userList = userData?.results
                completionHnadler(true, "")
            }
            else {
                completionHnadler(false, error)                
            }
        }
    }
}
