//
//  RecipeDetail.swift
//  Reciplease
//
//  Created by Nathalie Ortonne on 09/10/2020.
//  Copyright © 2020 Nathalie Ortonne. All rights reserved.
//

import Foundation

class RecipeDetail {

    var title: String = ""
    var ingredientList = [Ingredient]()
    var imageUrl: String = ""

}

class FavoriteRecipe {

    var recipes = [Recipe]()

    func addFavoriteRecipe(for currentRecipe: Recipe, favorite: Bool){
        if favorite {
            recipes.append(currentRecipe)
        } else {
            for recipe in recipes {
                if recipe.label == currentRecipe.label && recipe.url == currentRecipe.url {
                   guard let index = recipes.firstIndex(where: { (recipe) -> Bool in
                        return recipe.label == currentRecipe.label && recipe.url == currentRecipe.url
                   }) else { return }
                    recipes.remove(at: index)
                }
            }
        }
    }
}

