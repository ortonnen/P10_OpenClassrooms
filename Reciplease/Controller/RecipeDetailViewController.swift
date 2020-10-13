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
    var favoriteRecipe = FavoriteRecipe()
    var isFavorite = false



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

        // Do any additional setup after loading the view.
    }

    @IBAction func tappedAddRecipeToFavorite(_ sender: Any) {
        if isFavorite == false {
            favoriteButton.image = #imageLiteral(resourceName: "addToFavorite.png")
            isFavorite = true
            favoriteRecipe.addFavoriteRecipe(for: currentRecipe, favorite: isFavorite)
        } else {
            favoriteButton.image = #imageLiteral(resourceName: "favorite.png")
            isFavorite = false
        }
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
