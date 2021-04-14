//
//  StorageManager.swift
//  ToDoList CoreData
//
//  Created by MacBook Pro on 14.04.2021.
//

import Foundation
import CoreData

class StorageManager {
    
    static let shared = StorageManager()

    // MARK: - Core Data Stack

    private var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ToDoList_CoreData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    private var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    private init() {}
    
    // MARK: - Public Methods

    
    func fetchData()  -> [Task] {
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()  // Запрос выборки по ключу Task
        do {
        return try viewContext.fetch(fetchRequest)
        } catch let error {
            print("Failed to fetch data", error)
            return []
        }
    }
    
    // Save data
    func save(_ taskName: String, completion: (Task) -> Void) {
        
        guard let entity = NSEntityDescription.entity(
            forEntityName: "Task",
            in: persistentContainer.viewContext
            ) else { return } // Create entity
        
        let task = NSManagedObject(entity: entity,
                                   insertInto: viewContext) as! Task // Task instace
        task.name = taskName // New value for task name
        
        completion(task)
        saveContext()
    }
    
    func edit(_ task: Task, newName: String) {
        task.name = newName
        saveContext()
    }
    
    func delete(_ task: Task) {
        viewContext.delete(task)
        saveContext()
    }

    // MARK: - Core Data Saving support

    func saveContext () {
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
