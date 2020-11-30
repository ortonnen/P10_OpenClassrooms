//
//  RecipesViewController.swift
//  Reciplease
//
//  Created by Nathalie Ortonne on 22/09/2020.
//  Copyright © 2020 Nathalie Ortonne. All rights reserved.
//

import UIKit


class RecipesViewController: UIViewController {

    //MARK: - Properties
    var ingredients: [String] = []
    var recipeServices = RecipesServices()
    private var recipesHit = [Hit]()

    //MARK: - Outlet
    @IBOutlet weak var recipeTableView: UITableView!

    //MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        recipeTableView.dataSource = self
        getRecipe()
    }

    ///method to retrieve Hit array and pass it to current into the RecipesDetailViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let recipesVC = segue.destination as? RecipeDetailViewController else {
            return
        }
        guard let indexPath = recipeTableView.indexPathForSelectedRow else {return}
        recipesVC.currentRecipe = recipesHit[indexPath.row].recipe
    }

    ///network call method for the API
    fileprivate func getRecipe() {
        recipeServices.getRecipes(with: ingredients) {(result) in

            DispatchQueue.main.async {
                switch result {

                case .success(let recipes):
                    self.recipesHit = recipes.hits
                    guard self.recipesHit.count > 0 else { return self.recipeNotFoundAlerte()}
                    self.recipeTableView.reloadData()

                case .failure(let error):
                    if error == .decodeDataError{
                        print(error.self)
                    } else if error == .error {
                        print(error.self)
                    } else if error == .noData {
                        print(error.self)
                    } else if error == .statusCodeError {
                        print(error.self)
                    }
                }
            }
        }
    }
}

//MARK: - TableView
extension RecipesViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipesHit.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath) as? RecipesTableViewCell else {
            return UITableViewCell()
        }

        if recipesHit.count > 0 {
            cell.configure(withTitle: recipesHit[indexPath.row].recipe.label, subTitle: recipesHit[indexPath.row].recipe.ingredientLines, like: recipesHit[indexPath.row].recipe.yield, timing: recipesHit[indexPath.row].recipe.totalTime, imageUrl: recipesHit[indexPath.row].recipe.image)
            return cell
        } else {
            cell.configure(withTitle: "No recipe", subTitle: [""], like: 0, timing: 0, imageUrl:"")
            return cell
        }
    }
}

//MARK: - Alerte
extension RecipesViewController {
    /// alerte if no recipe Found
    private func recipeNotFoundAlerte() {
        let alerte = UIAlertController(title: "No recipes found", message: "please check the ingredient list ", preferredStyle: .alert)
        let alerteAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alerte.addAction(alerteAction)
        self.present(alerte, animated: true, completion: nil)
    }
}
