//
//  UserTranslation.swift
//  MVVM+DependencyInjection
//
//  Created by Bansi Hirpara on 2023-01-15.
//

import Foundation
import CoreData

class UserTranslator {
    
    func translate(from userDM: UserDM?) -> UserModel? {
        guard let userDM = userDM else { return nil }
        let name = userDM.name?.components(separatedBy: " ")
        
        var userModel = UserModel()
        userModel.email = userDM.email
        userModel.name = Name(title: "", first: name?.first, last: name?.last)
        userModel.gender = userDM.gender
        
        return userModel
    }
    
    func translate(from userModal: UserModel?, with context: NSManagedObjectContext) -> UserDM? {
        guard let userModal = userModal else { return nil }
        
        let userDM = UserDM(context: context)
        userDM.email = userModal.email
        userDM.name = "\(userModal.name?.first ?? "") \(userModal.name?.last ?? "")"
        userDM.gender = userModal.gender
        
        return userDM
    }
}
