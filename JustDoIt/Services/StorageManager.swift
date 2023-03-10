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
    
    func fetchedResultsController(entityName: String, keysForSort: [String]) -> NSFetchedResultsController<NSFetchRequestResult> {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        var sortDescriptors: [NSSortDescriptor] = []
        keysForSort.forEach { keyForSort in
            let sortDescriptor = NSSortDescriptor(key: keyForSort, ascending: true)
            sortDescriptors.append(sortDescriptor)
        }
        fetchRequest.sortDescriptors = sortDescriptors
        
        let fetchResultsController = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: viewContext,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        return fetchResultsController
    }
    
    func saveTask(withTitle title: String, andPriority priority: Int16) { // Реализуем метод для создания и сохранения задачи в базе данных
        let task = Task(context: viewContext) // создаём экз сущности Task
        task.title = title
        task.priority = priority
        task.date = Date()
        task.isComplete = false
        saveContext() // вызываем метод для внесения изменений в базу
    }
    
    func delete(task: Task) {
        viewContext.delete(task)
        saveContext()
    }
    
    func edit(task: Task, with newTitle: String, and priority: Int16) { // реализация возможности редактирования задачи
        task.title = newTitle
        task.priority = priority
        saveContext()
    }
    
    func done(task: Task) {
        task.isComplete.toggle()
        saveContext()
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

