//
//  UserService.swift
//  MVVM+DependencyInjection
//
//  Created by Bansi Hirpara on 2022-06-05.
//

import UIKit

protocol UserService: AnyObject {
    func getAllUsers(completionHnadler: @escaping (UserDatas?, String)->())
}

class UserServiceObject: HTTPClient, UserService {
    func getAllUsers(completionHnadler: @escaping (UserDatas?, String)->()) {
        sendRequest(request: UserEndPoints.GetUser(10), responseModal: UserDatas.self) { userData, error in
            if let userData = userData {
                print("userData --->>>> \(userData)")
                completionHnadler(userData, "")
            }
            else {
                print(error?.message ?? "Error in getting users")
                completionHnadler(nil, error?.message ?? "Error in getting users")
            }
        }
    }
}
