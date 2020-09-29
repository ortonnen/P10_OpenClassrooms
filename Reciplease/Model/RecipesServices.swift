//
//  RecipesServices.swift
//  Reciplease
//
//  Created by Nathalie Ortonne on 18/09/2020.
//  Copyright © 2020 Nathalie Ortonne. All rights reserved.
//

import Foundation
import Alamofire

class RecipesServices {
    
    //MARK: Properties
    private let recipesURL = URL(string: "https://api.edamam.com/search?")!
    private let apikey = "1ca6fa53868439f0dff48a62bed5b933"
    private let apiId = "ae5de728"
    
    
    
    func getRecipes(with ingredients: [String], callback: @escaping (Bool, Recipes?) -> Void) {
        
        var ingredient = ""
        
        if ingredients.count < 1 {
            ingredient = ingredients.joined(separator: ",")
        } else {
            ingredient = ingredients[0]
        }
        
        guard let url = URL(string: "\(recipesURL)&q=\(ingredient)))&app_id=\(apiId)&app_key=\(apikey)") else { return }
        
        Alamofire.request(url).responseJSON { (response) in
            if response.data != nil {
                do {
                    let responseJSON = try JSONDecoder().decode(Recipes.self, from: response.data!)
                    callback(true, responseJSON)
                } catch {
                    callback(false, nil)
                }
            }
        }
    }
}


