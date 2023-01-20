//
//  CoreDataHelper.swift
//  MVVM+DependencyInjection
//
//  Created by Bansi Hirpara on 2023-01-14.
//

import UIKit
import CoreData

typealias UserDMBlock = ([UserDM], Error?) -> ()

class CoreDataHelper: NSObject {
    private let modelName: String
    
    init(modelName: String) {
        self.modelName = modelName
    }
    
    private lazy var storeContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: self.modelName)
        
        /*add necessary support for migration*/
        let description = NSPersistentStoreDescription()
        description.shouldMigrateStoreAutomatically = true
        description.shouldInferMappingModelAutomatically = true
//        container.persistentStoreDescriptions = [description]
        
        container.loadPersistentStores { storeDesc, error in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    lazy var managedContext: NSManagedObjectContext = self.storeContainer.viewContext
    
    lazy var backgroundContext: NSManagedObjectContext = self.storeContainer.newBackgroundContext()
    
    func getEntity(entityName: String) -> NSEntityDescription {
        guard let entity = NSEntityDescription.entity(forEntityName: entityName, in: managedContext) else { fatalError() }
        return entity
    }
    
    func saveContext() {
        guard managedContext.hasChanges else { return }
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
    
//    func fetchData(of entityName: String, completionHandler: ((Any?, Error?) -> ())) {
//        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
//        request.returnsObjectsAsFaults = false
//
//        do {
//            let result = try managedContext.fetch(request)
//            completionHandler(result, nil)
//        } catch (let error) {
//            completionHandler(nil, error)
//        }
//    }
}

extension CoreDataHelper {
    func syncUserData(userList: [UserModel], translation: Transalation) {
        clearOldUserResults()
        _ = translation.toUserDMs(from: userList, with: managedContext)
        saveContext()
    }
    
    func fetchUserDataFromLocalDB(completionHandler: UserDMBlock) {
        let sortOn = NSSortDescriptor(key: "name", ascending: true)
        let fetchRequest: NSFetchRequest<UserDM> = UserDM.fetchRequest()
        fetchRequest.sortDescriptors = [sortOn]
        
        do {
            let userDMs = try managedContext.fetch(fetchRequest)
            completionHandler(userDMs, nil)
        } catch (let error) {
            completionHandler([], error)
        }
    }
    
    fileprivate func clearOldUserResults() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserDM")
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        try! managedContext.execute(batchDeleteRequest)
        managedContext.reset()
    }
}
