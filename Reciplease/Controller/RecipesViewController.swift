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

    @IBOutlet weak var recipeTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        recipeTableView.dataSource = self
        // Do any additional setup after loading the view.
        recipeTableView.reloadData()
        recipeServices.getRecipes(with: ingredients) { (success, recipes) in
            DispatchQueue.main.async {
                guard success else {
                    print("error success")
                    return
                }
                guard recipes != nil else {
                    print("error recipes")
                    return
                }
                print ("call is ok")
            }
        }
        print("view\(ingredients)")
    }
}

extension RecipesViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients.count

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath) as? RecipesTableViewCell else {
            return UITableViewCell()
        }
        let ingredient = ingredients[indexPath.row]

        cell.configure(withTitle: ingredient, subTitle: ingredient, like: 14, timing: 30)


        return cell
    }

}
