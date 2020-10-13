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

    var recipe = [Recipe]()
    var isFavorite = true
}
