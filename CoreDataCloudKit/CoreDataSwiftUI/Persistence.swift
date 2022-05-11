//
//  Persistence.swift
//  CoreDataSwiftUI
//
//  Created by Eugene G on 5/5/22.
//

import CoreData

@objcMembers
class PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for x in 0..<5 {
            let newFruit = Fruit(context: viewContext)
            newFruit.name = "Fruit \(x)"
        }
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "CoreDataSwiftUI") //           Must for CloudKit
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.viewContext.automaticallyMergesChangesFromParent = true //            Must for CloudKit
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy //  Must for CloudKit, (the in memory changes - source of truth)

        
        
        // OPTIONAL - Notifications start
        guard let description = container.persistentStoreDescriptions.first else {
            fatalError("No Descriptions found")
        }
        description.setOption(true as NSObject, forKey: NSPersistentStoreRemoteChangeNotificationPostOptionKey)
        NotificationCenter.default.addObserver(self, selector: #selector(self.processUpdate), name: .NSPersistentStoreRemoteChange, object: nil)
        // OPTIONAL - Notifications end

        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                Typical reasons for an error here include:
                * The parent directory does not exist, cannot be created, or disallows writing.
                * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                * The device is out of space.
                * The store could not be migrated to the current model version.
                Check the error message to determine what the actual problem was.
                */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
    
    deinit{
        NotificationCenter.default.removeObserver(self)
    }
    
    // OPTIONAL - Notifications Method
    @objc func processUpdate(notification: NSNotification) {
        print("Cloud stuff updated, notification triggered")
        
        
        operationQueue.addOperation {
            // get our context
            let context = self.container.newBackgroundContext()
            context.performAndWait {
                
                
                let request = Fruit.fetchRequest() as NSFetchRequest<Fruit>
                // Sort, by name
                let sort = NSSortDescriptor(key: "name", ascending: true)
                request.sortDescriptors = [sort]

                
//                // get list items out of store
                let items: [Fruit]
                do {
                    items = try context.fetch(request)
                } catch {
                    let nserror = error as NSError
                    fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                }
                
                print("\nNew Line Thread main: \(Thread.isMainThread)")
                for item in items {
                    print("\(item.name)")
                }
                var i=0
                var j=0
                while j<items.count-1 {

                    if items[j].name == items[j+1].name {
                        let tmp = items[j].name
                        i=j
                        var count = 0
                        while i<items.count && items[i].name == tmp {
                            if let n = items[i].name {
                                items[i].name = "\(n) - \(count)"
                            }
                            count += 1
                            i += 1
                        }
                        if j != i {
                            j = i
                            continue
                        }
                    }
                    j += 1
                }
                
                
                // save if we need to save
                if context.hasChanges {
                    print("CHANGED: ")
                    for item in items {
                        print("\(item.name)")
                    }
                    do {
                        try context.save()
                        print("Save Thread main: \(Thread.isMainThread) \n")
                    } catch {
                        let nserror = error as NSError
                        fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                    }
                }
                
                
            }
            
        }

        
        
        
        
    }

    
    
    // OPTIONAL - Notifications, operation queue
    lazy var operationQueue: OperationQueue = {
       var queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
        return queue
    }()

    
}
