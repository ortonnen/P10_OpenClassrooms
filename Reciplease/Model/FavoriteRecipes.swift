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

    private let favoriteRecipes = FavoriteRecipes.all

    private func deleteRecipe(_ currentRecipe: Recipe) {
        let request: NSFetchRequest<FavoriteRecipes> = FavoriteRecipes.fetchRequest()
        let predicate = NSPredicate(format: "title == %@", currentRecipe.label)

        request.predicate = predicate

        if let recipe = try? AppDelegate.viewContext.fetch(request) {
            recipe.forEach(AppDelegate.viewContext.delete(_:))
        }
        try? AppDelegate.viewContext.save()

    }



    private func saveRecipe(for currentRecipe: Recipe) {
        let recipe = FavoriteRecipes(context: AppDelegate.viewContext)
        recipe.title = currentRecipe.label
        recipe.ingredients = currentRecipe.ingredients[0].text
        recipe.isFavorite = true
        try? AppDelegate.viewContext.save()
    }

    func removeRecipe(_ currentRecipe: Recipe) {
        guard favoriteRecipes.count > 0 else { return }
        deleteRecipe(currentRecipe)
    }

    func addFavoriteRecipe(_ currentRecipe: Recipe) {
        saveRecipe(for: currentRecipe)
    }

}
