//
//  FakeCoreDataTask.swift
//  RecipleaseTests
//
//  Created by Nathalie Ortonne on 16/11/2020.
//  Copyright © 2020 Nathalie Ortonne. All rights reserved.
//

import Foundation
import CoreData
import Reciplease

class FakeCoreDataStack: CoreDataStack {
    
    // MARK: - Initializer
    convenience init() {
        self.init(modelName: "Reciplease")
    }
    
    ///creation of a new store container
    override init(modelName: String) {
        super.init(modelName: modelName)
        let persistentStoreDescription = NSPersistentStoreDescription()
        persistentStoreDescription.type = NSInMemoryStoreType
        let container = NSPersistentContainer(name: modelName)
        container.persistentStoreDescriptions = [persistentStoreDescription]
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        self.storeContainer = container
    }
}
