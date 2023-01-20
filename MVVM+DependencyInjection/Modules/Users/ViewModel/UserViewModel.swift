//
//  UserViewModel.swift
//  MVVM+DependencyInjection
//
//  Created by Bansi Hirpara on 2022-07-05.
//

import Foundation

typealias BlockWithResult = (Bool, String?) -> ()

class UserViewModel {
    var userList: [UserModel]?
    
    private let dataProvider: DataProvider!
    
    init(dataProvider: DataProvider) {
        self.dataProvider = dataProvider
    }
    
    func getUsers(completionHandler: @escaping BlockWithResult) {
        dataProvider.getUsers { [unowned self] userData, error in
            userList = userData
            completionHandler((error == ""), error)
        }
    }
}
