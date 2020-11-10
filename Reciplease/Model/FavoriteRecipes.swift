//
//  FavoriteRecipes.swift
//  Reciplease
//
//  Created by Nathalie Ortonne on 28/10/2020.
//  Copyright © 2020 Nathalie Ortonne. All rights reserved.
//

import Foundation
import CoreData

class FavoriteRecipes: NSManagedObject{

    static var all: [FavoriteRecipes] {
        let request: NSFetchRequest<FavoriteRecipes> = FavoriteRecipes.fetchRequest()
        guard let favoritesRecipes = try? AppDelegate.viewContext.fetch(request) else { return [] }
        return favoritesRecipes
    }

}
