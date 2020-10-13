//
//  FavoriteRecipesViewController.swift
//  Reciplease
//
//  Created by Nathalie Ortonne on 12/10/2020.
//  Copyright © 2020 Nathalie Ortonne. All rights reserved.
//

import UIKit

class FavoriteRecipesViewController: UIViewController {

var favoriteRecipe = FavoriteRecipe()

    @IBOutlet weak var FavoriteRecipeTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        print(favoriteRecipe.recipes)
        // Do any additional setup after loading the view.
    }
    


}
//MARK: TableView
extension FavoriteRecipesViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteRecipe.recipes.count

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteRecipeCell", for: indexPath) as? FavoriteRecipesTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(withTitle: favoriteRecipe.recipes[indexPath.row].label, subTitle: favoriteRecipe.recipes[indexPath.row].ingredients[indexPath.row].text, imageUrl: favoriteRecipe.recipes[indexPath.row].image)
        return cell
    }
}

