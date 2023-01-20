//
//  Translation.swift
//  MVVM+DependencyInjection
//
//  Created by Bansi Hirpara on 2023-01-15.
//

import Foundation
import CoreData

class Transalation {
    
    fileprivate var userTranslator = UserTranslator()
    
    func toUserDMs(from userModals: [UserModel], with context: NSManagedObjectContext) -> [UserDM] {
        let coreDMs = userModals.compactMap { userTranslator.translate(from: $0, with: context) }
        return coreDMs
    }
    
    func toUserModals(from userDMs: [UserDM]) -> [UserModel] {
        let userModals = userDMs.compactMap { userTranslator.translate(from: $0) }
        return userModals
    }
}
