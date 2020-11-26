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
    //MARK: - Properties
    let managedObjectContext: NSManagedObjectContext
    let coreDataStack: CoreDataStack

    // MARK: - Initializers
    init(coreDataStack: CoreDataStack) {
           self.coreDataStack = coreDataStack
           self.managedObjectContext = coreDataStack.mainContext
       }

    var favoritesRecipes: [FavoriteRecipes] {
            let request: NSFetchRequest<FavoriteRecipes> = FavoriteRecipes.fetchRequest()
            guard let recipes = try? managedObjectContext.fetch(request) else { return [] }
            return recipes
        }

    //MARK: - Methods
    func deleteRecipe(_ currentRecipeTitle: String) {
            let request: NSFetchRequest<FavoriteRecipes> = FavoriteRecipes.fetchRequest()
            request.predicate = NSPredicate(format: "name = %@", currentRecipeTitle)
        guard let recipe = try? managedObjectContext.fetch(request).first else { return }
                managedObjectContext.delete(recipe)
        coreDataStack.saveContext()

        }

    func saveRecipe(for currentRecipe: Recipe) {
        let recipe = FavoriteRecipes(context: managedObjectContext)

        recipe.name = currentRecipe.label
        recipe.ingredients = currentRecipe.ingredientLines.joined(separator: ",")
        recipe.urlImage = currentRecipe.image
        recipe.timer = currentRecipe.totalTime
        recipe.like = currentRecipe.yield
        coreDataStack.saveContext()
    }

    func checkIfRecipeIsFavorite(for currentRecipeTitle: String) -> Bool {
        let request: NSFetchRequest<FavoriteRecipes> = FavoriteRecipes.fetchRequest()
        request.predicate = NSPredicate(format: "name = %@", currentRecipeTitle)
        guard let recipe = try? managedObjectContext.fetch(request) else {
            return false
        }
        guard recipe.isEmpty == false else {
            return false
        }
        return true
    }

    func map(for favoriteRecipe: FavoriteRecipes) -> Recipe {
        guard let ingredientsList = favoriteRecipe.ingredients else { return Recipe(uri: "", label: "No Title", image: "", url: "", yield: 0, ingredientLines: [""], totalTime: 0) }
        let ingredients = (ingredientsList.components(separatedBy: ","))

        return Recipe(uri: "", label: favoriteRecipe.name! , image: favoriteRecipe.urlImage!, url: "", yield: 10, ingredientLines: ingredients, totalTime: 10)
    }
}
