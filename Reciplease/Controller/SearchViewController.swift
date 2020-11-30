//
//  SearchViewController.swift
//  Reciplease
//
//  Created by Nathalie Ortonne on 21/09/2020.
//  Copyright © 2020 Nathalie Ortonne. All rights reserved.
//

import UIKit


class SearchViewController: UIViewController {

    //MARK: - Properties
    var ingredients: [String] = []

    //MARK: - Outlet
    @IBOutlet weak var ingredientTextField: UITextField!
    @IBOutlet weak var ingredientListeTableView: UITableView!

    //MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        ingredientListeTableView.dataSource = self
        ingredientListeTableView.delegate = self
    }

    ///method to retrieve the ingredient array and pass it into the RecipesViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard ingredients.count > 0 else {
            textIsEmptyAlerte()
            return
        }
        guard let recipesVC = segue.destination as? RecipesViewController else {
            return
        }
        recipesVC.ingredients = ingredients
    }

    ///method to add ingredient in array
    private func addIngredient(for ingredient: String) {
        ingredients.append(ingredient)
        ingredientListeTableView.reloadData()
    }

    //MARK: - Action
    @IBAction func tappedAddIngredientButton() {
        guard let text = ingredientTextField.text, !text.isEmpty else {
            textIsEmptyAlerte()
            return }
        addIngredient(for: ingredientTextField.text ?? "")
        ingredientTextField.text = ""
    }

    @IBAction func tappedClearButton(_ sender: Any) {
        ingredients.removeAll()
        ingredientTextField.text = ""
        ingredientListeTableView.reloadData()
    }
}

//MARK: - TableView
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

//MARK: - Alerte
extension SearchViewController {
    /// alert if ingredient text is empty
    private func textIsEmptyAlerte() {
        let alerte = UIAlertController(title: "Empty Ingredient Field", message: "please enter an ingredient ", preferredStyle: .alert)
        let alerteAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alerte.addAction(alerteAction)
        self.present(alerte, animated: true, completion: nil)
    }
}

//MARK: - Keyboard
extension SearchViewController {

    @IBAction func dismissKeyboard(_ sender: Any) {
        ingredientTextField.resignFirstResponder()
    }
}
