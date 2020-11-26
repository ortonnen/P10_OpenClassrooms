//
//  CoreDataStack.swift
//  Reciplease
//
//  Created by Nathalie Ortonne on 16/11/2020.
//  Copyright © 2020 Nathalie Ortonne. All rights reserved.
//


import Foundation
import CoreData

open class CoreDataStack {
    
    private let modelName: String

    // MARK: - Initializer
    public init(modelName: String) {
        self.modelName = modelName
    }

    //MARK: - Properties
    lazy var mainContext: NSManagedObjectContext = {
        return storeContainer.viewContext
    }()

    public lazy var storeContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: modelName )
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()

    //MARK: - Method
    public func saveContext() {
        guard mainContext.hasChanges else { return }
        do {
            try mainContext.save()
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
}
