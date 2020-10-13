//
//  RecipesViewController.swift
//  Reciplease
//
//  Created by Nathalie Ortonne on 22/09/2020.
//  Copyright © 2020 Nathalie Ortonne. All rights reserved.
//

import UIKit


class RecipesViewController: UIViewController {

    var ingredients: [String] = []
    var recipeServices = RecipesServices()
    private var recipesHit = [Hit]()
    

    @IBOutlet weak var recipeTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        recipeTableView.dataSource = self
        // Do any additional setup after loading the view.
        recipeServices.getRecipes(with: ingredients) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let recipes):
                    self.recipesHit = recipes.hits
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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        guard let recipesVC = segue.destination as? RecipeDetailViewController else {
            return
        }
        guard let indexPath = recipeTableView.indexPathForSelectedRow else {return}
        recipesVC.currentRecipe = recipesHit[indexPath.row].recipe
    }
}

//MARK: TableView
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

            cell.configure(withTitle: recipesHit[indexPath.row].recipe.label, subTitle: ingredients, like: recipesHit[indexPath.row].recipe.yield, timing: recipesHit[indexPath.row].recipe.totalTime, imageUrl: recipesHit[indexPath.row].recipe.image)

            return cell
        } else {
            cell.configure(withTitle: "No recipe", subTitle: [""], like: 0, timing: 0, imageUrl:"")
            return cell
        }
    }
}

//MARK: Alerte
extension RecipesViewController {

    private func ingredientNotFoundAlerte() {
        let alerte = UIAlertController(title: "Error", message: "please check the ingredient list ", preferredStyle: .alert)
        let alerteAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alerte.addAction(alerteAction)
        self.present(alerte, animated: true, completion: nil)
    }
}


