//
//  FavoriteRecipesViewController.swift
//  Reciplease
//
//  Created by Nathalie Ortonne on 12/10/2020.
//  Copyright © 2020 Nathalie Ortonne. All rights reserved.
//

import UIKit

class FavoriteRecipesViewController: UIViewController {
    var favoriteRecipes = FavoriteRecipes.all

    @IBOutlet weak var favoriteRecipeTableView: UITableView!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        favoriteRecipes = FavoriteRecipes.all
        favoriteRecipeTableView.reloadData()
        print(favoriteRecipes.count)

    }
}
//MARK: TableView
extension FavoriteRecipesViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteRecipes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteRecipeCell", for: indexPath) as? FavoriteRecipesTableViewCell else {
            return UITableViewCell()
        }
        guard favoriteRecipes.count > 0 else {
            return cell
        }
        
        cell.configure(withTitle: favoriteRecipes[indexPath.row].name ?? "No Recipe", subTitle: favoriteRecipes[indexPath.row].ingredients ?? "", imageUrl: favoriteRecipes[indexPath.row].urlImage ?? "https://www.edamam.com/web-img/d32/d32b4dc2e7bd9d4d1a24bbced0c89143.jpg")

        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        guard let recipe = favoriteRecipes[indexPath.row].name else { return }

        CoreDataManager.deleteRecipe(recipe)
        favoriteRecipes.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }

