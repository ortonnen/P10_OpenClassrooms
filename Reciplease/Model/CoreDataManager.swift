//
//  CoreDataManager.swift
//  Reciplease
//
//  Created by Nathalie Ortonne on 09/11/2020.
//  Copyright © 2020 Nathalie Ortonne. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {

    static func deleteRecipe(_ currentRecipeTitle: String) {
            let request: NSFetchRequest<FavoriteRecipes> = FavoriteRecipes.fetchRequest()
            request.predicate = NSPredicate(format: "name = %@", currentRecipeTitle)
        guard let recipe = try? AppDelegate.viewContext.fetch(request).first else { return }
                AppDelegate.viewContext.delete(recipe)
            try? AppDelegate.viewContext.save()
        }

    static func saveRecipe(for currentRecipe: Recipe) {
        let recipe = FavoriteRecipes(context: AppDelegate.viewContext)
        recipe.name = currentRecipe.label
        recipe.ingredients = currentRecipe.ingredients[0].text
        recipe.isFavorite = true
        recipe.urlImage = currentRecipe.url
        try? AppDelegate.viewContext.save()
    }

    static func checkIfRecipeIsFavorite (for currentRecipeTitle: String) -> Bool {
        let request: NSFetchRequest<FavoriteRecipes> = FavoriteRecipes.fetchRequest()
        request.predicate = NSPredicate(format: "name = %@", currentRecipeTitle)
        guard let recipe = try? AppDelegate.viewContext.fetch(request) else {
            return false
        }
        guard recipe.isEmpty == false else {
            return false
        }
        return true
    }
}
