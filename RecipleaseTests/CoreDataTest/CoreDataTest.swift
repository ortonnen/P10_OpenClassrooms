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
    //MARK: - Properties
    var coreDataStack: CoreDataStack!
    var coreDataManager: CoreDataManager!
    var recipe = Recipe(uri: "http://www.edamam.com/ontologies/edamam.owl#recipe_2fb391cceeec3d82920a2035f1849d72",
                        label: "Lemon Confit",
                        image: "https://www.edamam.com/web-img/d32/d32b4dc2e7bd9d4d1a24bbced0c89143.jpg",
                        url: "http://ruhlman.com/2011/03/lemon-confit/",
                        yield: 2.0,
                        ingredientLines: ["Kosher salt to cover (about 2 pounds/900 grams)"], totalTime: 0.0)

    //MARK: - Methods
    override func setUp() {
        super.setUp()
        coreDataStack = FakeCoreDataStack()
        coreDataManager = CoreDataManager(coreDataStack: coreDataStack)
    }

    override func tearDown() {
        super.tearDown()
        coreDataManager = nil
        coreDataStack = nil
    }

    func testAddTeskMethods_WhenRecipeAddInFavorite_ThenShouldBeCorrectlySaved() {
        coreDataManager.saveRecipe(for: recipe)

        XCTAssertTrue(!coreDataManager.favoritesRecipes.isEmpty)
        XCTAssertTrue(coreDataManager.favoritesRecipes.count == 1)
        XCTAssertTrue(coreDataManager.favoritesRecipes[0].name == "Lemon Confit")
    }

    func testDeleteRecipe_WhenRecipeAddInFavorite_ThenShouldBeCorrectlyDeleted() {
        coreDataManager.saveRecipe(for: recipe)
        coreDataManager.deleteRecipe(recipe.label)

        XCTAssertTrue(coreDataManager.favoritesRecipes.isEmpty)
    }

    func testAddRecipe_WhenRecipeAddInFavorite_ThenShouldHaveRecipeInCoreData() {
        coreDataManager.saveRecipe(for: recipe)

        XCTAssertTrue(coreDataManager.checkIfRecipeIsFavorite(for: recipe.label))
        XCTAssertTrue(!coreDataManager.favoritesRecipes.isEmpty)
        XCTAssertTrue(coreDataManager.favoritesRecipes.count == 1)
        XCTAssertTrue(coreDataManager.favoritesRecipes[0].name == "Lemon Confit")
    }

    func testAddRecipeAndDeleteRecipe_WhenRecipeIsAlreadyPresentAndItIsDelete_ThenShouldHaveNotAddRecipeInCoreData() {
        coreDataManager.saveRecipe(for: recipe)
        XCTAssertTrue(coreDataManager.checkIfRecipeIsFavorite(for: recipe.label))
        XCTAssertTrue(!coreDataManager.favoritesRecipes.isEmpty)
        XCTAssertTrue(coreDataManager.favoritesRecipes.count == 1)
        XCTAssertTrue(coreDataManager.favoritesRecipes[0].name == "Lemon Confit")

        coreDataManager.deleteRecipe(recipe.label)

        XCTAssertFalse(coreDataManager.checkIfRecipeIsFavorite(for: recipe.label))
        XCTAssertTrue(coreDataManager.favoritesRecipes.isEmpty)
    }

    func testAddRecipes_WhenManyRecipeAddInFavorite_ThenShouldHaveAllRecipeInCoreData() {
        coreDataManager.saveRecipe(for: recipe)
        coreDataManager.saveRecipe(for: recipe)
        coreDataManager.saveRecipe(for: recipe)

        XCTAssertTrue(!coreDataManager.favoritesRecipes.isEmpty)
        XCTAssertTrue(coreDataManager.favoritesRecipes.count == 3)
    }

    func testMapRecipe_WhenFavoriteRecipeMapToRecipe_ThenShouldHaveRecipe() {
        var newRecipe: Recipe

        coreDataManager.saveRecipe(for: Recipe(uri: "", label: "Salmon", image: "image", url: "", yield: 10, ingredientLines:["salmon", "lemon"], totalTime: 1.5))

        newRecipe = coreDataManager.map(for: coreDataManager.favoritesRecipes[0])

        XCTAssertEqual(coreDataManager.favoritesRecipes[0].name, newRecipe.label)
        XCTAssertEqual(coreDataManager.favoritesRecipes[0].urlImage, newRecipe.image)
    }
}



