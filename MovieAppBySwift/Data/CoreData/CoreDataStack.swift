//
//  CoreDataStack.swift
//  MovieAppBySwift
//
//  Created by 梁世仪 on 2023/7/1.
//

import Foundation
import CoreData

class CoreDataStack: NSObject {
    
    static let shared = CoreDataStack()
    
    let persistentContainer : NSPersistentContainer
    
    var context: NSManagedObjectContext {
        get {
            persistentContainer.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
            return persistentContainer.viewContext
        }
    }
    private override init() {
        persistentContainer = NSPersistentContainer(name: "MovieDB")
        
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Core data store failed to load with error : \(error)")
            }
        }
    }
    func saveContext() {
        let context = self.context
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let error = error as NSError
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
   
}
