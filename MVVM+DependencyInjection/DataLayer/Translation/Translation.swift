//
//  Translation.swift
//  MVVM+DependencyInjection
//
//  Created by Bansi Hirpara on 2023-01-15.
//

import Foundation
import CoreData

protocol Transalation {
    func toUserDMs(from userModals: [UserModel], with context: NSManagedObjectContext) -> [UserDM]
    func toUserModals(from userDMs: [UserDM]) -> [UserModel]
}

class TransalationImp: Transalation {
    
    fileprivate var userTranslator: UserTranslator
    
    init(userTranslator: UserTranslator) {
        self.userTranslator = userTranslator
    }
    
    func toUserDMs(from userModals: [UserModel], with context: NSManagedObjectContext) -> [UserDM] {
        let coreDMs = userModals.compactMap { userTranslator.translate(from: $0, with: context) }
        return coreDMs
    }
    
    func toUserModals(from userDMs: [UserDM]) -> [UserModel] {
        let userModals = userDMs.compactMap { userTranslator.translate(from: $0) }
        return userModals
    }
}
