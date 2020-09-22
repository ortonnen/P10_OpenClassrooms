//
//  RecipesViewController.swift
//  Reciplease
//
//  Created by Nathalie Ortonne on 22/09/2020.
//  Copyright © 2020 Nathalie Ortonne. All rights reserved.
//

import UIKit

class RecipesViewController: UIViewController {

    var searchRecipe = SearchViewController()

    @IBOutlet weak var recipeTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        recipeTableView.dataSource = self
        // Do any additional setup after loading the view.
        recipeTableView.reloadData()
    }
}

extension RecipesViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
//        return searchRecipe.ingredients.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath)
//        let ingredient = searchRecipe.ingredients[indexPath.row]

        cell.textLabel?.text = "ingredient"


        return cell
    }
}
