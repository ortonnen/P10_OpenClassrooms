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

    //MARK: - Properties
    var currentRecipe: Recipe!
    var coreDataManager: CoreDataManager?
    private var isFavorite = false

    //MARK: - Outlet
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeTitleLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    @IBOutlet weak var ingredientListTableView: UITableView!

    //MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let coredataStack = appdelegate.coreDataStack
        coreDataManager = CoreDataManager(coreDataStack: coredataStack)

        guard let url = URL(string:currentRecipe.image) else { return }
        recipeTitleLabel.text = currentRecipe.label
        recipeImage.af.setImage(withURL: url)
        ingredientListTableView.reloadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        if coreDataManager?.checkIfRecipeIsFavorite(for: currentRecipe.label) == true {
            isFavorite = true
            favoriteButton.image = #imageLiteral(resourceName: "addToFavorite.png")
        }
    }

    ///method to save recipe in Favorite
    fileprivate func addToFavorite() {
        favoriteButton.image = #imageLiteral(resourceName: "addToFavorite.png")
        coreDataManager?.saveRecipe(for: currentRecipe)
        isFavorite = true
    }

    ///method to delete recipe in favorite
    fileprivate func deleteToFavorite() {
        coreDataManager?.deleteRecipe(currentRecipe.label)
        favoriteButton.image = #imageLiteral(resourceName: "favorite.png")
        isFavorite = false
    }

    //MARK: - Action
    @IBAction func tappedAddRecipeToFavorite(_ sender: Any) {
        let favoriteRecipes = coreDataManager?.favoritesRecipes
        guard favoriteRecipes?.count ?? 0 > 0 else {
            addToFavorite()
            return
        }
        guard isFavorite == false else {
            deleteToFavorite()
            return
        }
        addToFavorite()
    }
}

//MARK: - TableView
extension RecipeDetailViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentRecipe.ingredientLines.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ingredientListTableView.dequeueReusableCell(withIdentifier: "ingredientListCell", for: indexPath)
        let ingredient = currentRecipe.ingredientLines[indexPath.row]
        cell.textLabel?.text = "- \(ingredient)"

        return cell
    }
}
