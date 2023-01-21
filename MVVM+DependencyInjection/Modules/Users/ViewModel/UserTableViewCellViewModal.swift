//
//  UserTableViewCellViewModal.swift
//  MVVM+DependencyInjection
//
//  Created by Bansi Hirpara on 2023-01-21.
//

import Foundation

protocol UserTableViewCellViewModal {
    var userData: UserModel! { get }
    
    var name: String { get }
    var email: String { get }
    var phone: String { get }
}

class UserTableViewCellViewModalImp: UserTableViewCellViewModal {
    var userData: UserModel!
    
    var name: String { return (userData.name?.first ?? "") + " " + (userData.name?.last ?? "") }
    var email: String { return userData.email ?? "" }
    var phone: String { return userData.phone ?? "" }
    
    init(userData: UserModel) {
        self.userData = userData
    }
}
