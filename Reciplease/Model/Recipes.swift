//
//  Recipes.swift
//  Reciplease
//
//  Created by Nathalie Ortonne on 18/09/2020.
//  Copyright © 2020 Nathalie Ortonne. All rights reserved.
//

import Foundation

// MARK: - Recipes
struct Recipes: Codable {
    let q: String
    let from, to: Int
    let more: Bool
    let count: Int
    let hits: [Hit]
}

// MARK: - Hit
struct Hit: Codable {
    let recipe: Recipe
}

// MARK: - Recipe
struct Recipe: Codable {
    let uri: String
    let label: String
    let image: String
    let url: String
    let yield: Double
    let healthLabels, ingredientLines: [String]
    let ingredients: [Ingredient]
    let totalTime: Double
}

// MARK: - Ingredient
struct Ingredient: Codable {
    let text: String
    let weight: Double
    let image: String?
}

// MARK: - RecipesError
struct RecipesError: Codable {
    let status, message: String
}
