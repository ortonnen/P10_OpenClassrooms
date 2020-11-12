//
//  CoreDataTest.swift
//  RecipleaseTests
//
//  Created by Nathalie Ortonne on 10/11/2020.
//  Copyright © 2020 Nathalie Ortonne. All rights reserved.
//

import XCTest
import CoreData
@testable import Reciplease


class CoreDataTest: XCTestCase {

    private let fakeRecipe = Recipe(uri: "",
                                    label: "Lemon Confit",
                                    image: "https://www.edamam.com/web-img/d32/d32b4dc2e7bd9d4d1a24bbced0c89143.jpg",
                                    url: "",
                                    yield: 2.0,
                                    healthLabels: [""],
                                    ingredientLines: [
        "Kosher salt to cover (about 2 pounds/900 grams)"],
                                    ingredients: [Ingredient(text: "Kosher salt to cover (about 2 pounds/900 grams)",
                                    weight: 907.18474,
                                    image: "https://www.edamam.com/food-img/694/6943ea510918c6025795e8dc6e6eaaeb.jpg")],
                                    totalTime: 0.0)


    override func setUp() {
        CoreDataManager.deleteRecipe(fakeRecipe.label)
    }
    override func tearDown() {
        CoreDataManager.deleteRecipe(fakeRecipe.label)
    }
    
    func testGivenFavoriteAvailable_WhenAddFavorite_ThenFavoriteIsAddedAndExists() {
        CoreDataManager.saveRecipe(for: fakeRecipe)
        XCTAssertTrue(CoreDataManager.checkIfRecipeIsFavorite(for: fakeRecipe.label))
        XCTAssertTrue(CoreDataManager.checkIfRecipeIsFavorite(for: "Lemon Confit"))
    }

    func testdelete() {
        CoreDataManager.deleteRecipe(fakeRecipe.label)

        XCTAssertFalse(CoreDataManager.checkIfRecipeIsFavorite(for: fakeRecipe.label))
        XCTAssertFalse(CoreDataManager.checkIfRecipeIsFavorite(for: "Lemon Confit"))
    }
    
    func testGivenFavoriteCreatedAndRemoved_WhenAddFavoriteTestAndDeleteIt_ThenFavoriteTestShouldNotExist() {
        CoreDataManager.saveRecipe(for: fakeRecipe)

        XCTAssertTrue(CoreDataManager.checkIfRecipeIsFavorite(for: fakeRecipe.label))
        XCTAssertTrue(CoreDataManager.checkIfRecipeIsFavorite(for: "Lemon Confit"))

        CoreDataManager.deleteRecipe(fakeRecipe.label)

        XCTAssertFalse(CoreDataManager.checkIfRecipeIsFavorite(for: fakeRecipe.label))
        XCTAssertFalse(CoreDataManager.checkIfRecipeIsFavorite(for: "Lemon Confit"))
        }
}


