//
//  DataProvider.swift
//  MVVM+DependencyInjection
//
//  Created by Bansi Hirpara on 2023-01-15.
//

import Foundation

enum Source {
    case network
    case local
}

protocol DataProvider {
    typealias UserModalBlock = ([UserModel], String?)->()
    func getUsers(completionHnadler: @escaping UserModalBlock)
}

class DataProviderImp: DataProvider {
    
//    static let shared = DataProvider()
    
    fileprivate var userService: UserService?
    fileprivate var coreDataHelper = CoreDataHelper(modelName: "UserDataModal")
    fileprivate var translation = Transalation()
    
    init(){ }
    
    convenience init(userService: UserService) {
        self.init()
        self.userService = userService
    }
    
    func getUsers(completionHnadler: @escaping UserModalBlock) {
        guard let userService = userService else { return }
        userService.getAllUsers() { [unowned self] userData, error in
            if userData != nil {
                let userDict = userData?.results ?? []
                coreDataHelper.syncUserData(userList: userDict, translation: translation)
                completionHnadler(userDict, "")
            }
            else {
                coreDataHelper.fetchUserDataFromLocalDB { userModel, error in
                    if error != nil {
                        completionHnadler([], error?.localizedDescription)
                    }
                    else {
                        let userModals = translation.toUserModals(from: userModel)
                        completionHnadler(userModals, "")
                    }
                }
            }
        }
    }
}
