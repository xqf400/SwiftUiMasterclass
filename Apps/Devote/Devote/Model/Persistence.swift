//
//  Persistence.swift
//  Devote
//
//  Created by Fabian Kuschke on 22.08.22.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentCloudKitContainer //NSpersistenCloudContainer

    init(inMemory: Bool = false) {
        let storeURL = AppGroup.facts.containerURL.appendingPathComponent("Notes.plist")

        container = NSPersistentCloudKitContainer(name: "Notes") //NSPersistentContainer
        let description = container.persistentStoreDescriptions.first
        description?.url = storeURL
        description?.cloudKitContainerOptions = NSPersistentCloudKitContainerOptions(containerIdentifier: "iCloud.com.fku.ToFinish")
        if inMemory {
            print("in memory")
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        //container.persistentStoreDescriptions = [description] //Use?
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for i in 0..<5 {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
            newItem.task = "sample \(i)"
            newItem.completion = false
            newItem.showOnWidget = false
            newItem.id = UUID()
        }
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()
    
}

public enum AppGroup: String {
  case facts = "group.com.fku.ToFinish"

  public var containerURL: URL {
    switch self {
    case .facts:
      return FileManager.default.containerURL(
      forSecurityApplicationGroupIdentifier: self.rawValue)!
    }
  }
}
