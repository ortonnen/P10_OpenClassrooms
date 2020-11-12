//
//  RecipeDetailViewController.swift
//  Reciplease
//
//  Created by Nathalie Ortonne on 09/10/2020.
//  Copyright © 2020 Nathalie Ortonne. All rights reserved.
//

import UIKit
import AlamofireImage


class RecipeDetailViewController: UIViewController {

    var currentRecipe: Recipe!
    private var isFavorite = false
    private var favoriteRecipes = FavoriteRecipes.all

    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeTitleLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIBarButtonItem!

    @IBOutlet weak var ingredientListTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let url = URL(string:currentRecipe.image) else { return }
        recipeTitleLabel.text = currentRecipe.label
        recipeImage.af.setImage(withURL: url)
        ingredientListTableView.reloadData()

        if CoreDataManager.checkIfRecipeIsFavorite(for: currentRecipe.label) == true {
            isFavorite = true
            favoriteButton.image = #imageLiteral(resourceName: "addToFavorite.png")
        }
        
        // Do any additional setup after loading the view.
    }

    @IBAction func tappedAddRecipeToFavorite(_ sender: Any) {
        guard favoriteRecipes.count > 0 else {
            favoriteButton.image = #imageLiteral(resourceName: "addToFavorite.png")
            CoreDataManager.saveRecipe(for: currentRecipe)
            isFavorite = true
            return
        }
        guard isFavorite == false else {
            CoreDataManager.deleteRecipe(currentRecipe.label)
            favoriteButton.image = #imageLiteral(resourceName: "favorite.png")
            isFavorite = false
            return
        }
        CoreDataManager.saveRecipe(for: currentRecipe)
        favoriteButton.image = #imageLiteral(resourceName: "addToFavorite.png")
        isFavorite = true
    }
}


//MARK: TableView
extension RecipeDetailViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentRecipe.ingredients.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ingredientListTableView.dequeueReusableCell(withIdentifier: "ingredientListCell", for: indexPath)
        let ingredient = currentRecipe.ingredients[indexPath.row].text
        cell.textLabel?.text = "- \(ingredient)"


        return cell
    }
}
