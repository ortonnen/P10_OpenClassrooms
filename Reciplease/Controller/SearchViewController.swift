//
//  SearchViewController.swift
//  Reciplease
//
//  Created by Nathalie Ortonne on 21/09/2020.
//  Copyright © 2020 Nathalie Ortonne. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    var ingredients: [String] = []

    @IBOutlet weak var ingredientTextField: UITextField!
    @IBOutlet weak var ingredientListeTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        ingredientListeTableView.dataSource = self
        // Do any additional setup after loading the view.
    }

    @IBAction func tappedAddIngredientButton() {
        guard ingredientTextField.text != nil else { return }
        addIngredient(for: ingredientTextField.text ?? "")
        ingredientTextField.text = ""
    }

    private func addIngredient(for ingredient: String) {
        ingredients.insert(ingredient, at: 0)
        ingredientListeTableView.reloadData()
    }
}
extension SearchViewController: UITableViewDelegate {

}

extension SearchViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientCell", for: indexPath)

        let ingredient = ingredients[indexPath.row]
        cell.textLabel?.text = " - \(ingredient)"

        return cell
    }
}
//MARK: Keyboard
extension SearchViewController {

    @IBAction func dismissKeyboard(_ sender: Any) {
        ingredientTextField.resignFirstResponder()
    }
}

