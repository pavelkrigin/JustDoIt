//
//  StorageManager.swift
//  JustDoIt
//
//  Created by Pavel Krigin on 14.02.2023.
//

import CoreData

final class StorageManager {
    
    static let shared = StorageManager()
    
    // MARK: - Core Data Stack
    
    private let persistentContainer: NSPersistentContainer = {
        let container  = NSPersistentContainer(name: "Just Do It")
        container.loadPersistentStores(completionHandler: { (storeDiscription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    private var viewContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    private init() {}
}
