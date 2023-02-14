//
//  StorageManager.swift
//  JustDoIt
//
//  Created by Pavel Krigin on 14.02.2023.
//

import CoreData

final class StorageManager {
    
    static let shared = StorageManager()
    
    // MARK: - Core Data Stack entry point
    
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
    
    func getFetchedResultsController(entityName: String, keyForSort: String) -> NSFetchedResultsController<NSFetchRequestResult> {
        // Метод принимает два параметра: название сущности и параметр для сортировки записей. Это позволит определять по какому полю делать сортировку задач
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName) // запрос для выборки данных из базы
        let sortDescriptor = NSSortDescriptor(key: keyForSort, ascending: true) // объект NSSortDescriptor с параметрами, используемыми для сортировки данных
        
        fetchRequest.sortDescriptors = [sortDescriptor] // объект NSSortDescriptor добавляется в массив
        
        let fetchResultsController = NSFetchedResultsController( // Создание экземпляра класса NSFetchedResultsController на основе, созданного ранее запроса и параметров сортировки
            fetchRequest: fetchRequest,
            managedObjectContext: viewContext,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
            return fetchResultsController //функция возвращает созданный экземпляр
        
    }
    
    
    // MARK: - Core Data Saving support
    func saveContext() { // реализация метода для сохранения контекста
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

