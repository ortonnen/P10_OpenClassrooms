//
//  FavoriteRecipesViewController.swift
//  Reciplease
//
//  Created by Nathalie Ortonne on 12/10/2020.
//  Copyright © 2020 Nathalie Ortonne. All rights reserved.
//

import UIKit

class FavoriteRecipesViewController: UIViewController {

    //MARK: - Properties
    var coreDataManager: CoreDataManager?

    //MARK: - Outlet
    @IBOutlet weak var favoriteRecipeTableView: UITableView!

    //MARK: - Methods
    override func viewDidLoad() {
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let coredataStack = appdelegate.coreDataStack
        coreDataManager = CoreDataManager(coreDataStack: coredataStack)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        favoriteRecipeTableView.reloadData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let recipesVC = segue.destination as? RecipeDetailViewController else {
            return
        }
        guard let indexPath = favoriteRecipeTableView.indexPathForSelectedRow else {return}

        recipesVC.currentRecipe = coreDataManager?.map(for: (coreDataManager?.favoritesRecipes[indexPath.row])!)
    }
}

//MARK: - TableView
extension FavoriteRecipesViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coreDataManager?.favoritesRecipes.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteRecipeCell", for: indexPath) as? FavoriteRecipesTableViewCell else {
            return UITableViewCell()
        }
        guard let favoriteRecipes = coreDataManager?.favoritesRecipes else { return UITableViewCell() }

        guard favoriteRecipes.count > 0 else {
            return cell
        }

        cell.configure(withTitle: favoriteRecipes[indexPath.row].name!, subTitle: favoriteRecipes[indexPath.row].ingredients!, like: favoriteRecipes[indexPath.row].like, timing: favoriteRecipes[indexPath.row].timer, imageUrl: favoriteRecipes[indexPath.row].urlImage!)

        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        guard let recipe = coreDataManager?.favoritesRecipes[indexPath.row].name else { return }
        guard var favoriteRecipes = coreDataManager?.favoritesRecipes else {return}

        coreDataManager?.deleteRecipe(recipe)
        favoriteRecipes.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
}

