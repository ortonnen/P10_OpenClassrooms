//
//  RecipesServices.swift
//  Reciplease
//
//  Created by Nathalie Ortonne on 18/09/2020.
//  Copyright © 2020 Nathalie Ortonne. All rights reserved.
//

import Foundation

class RecipesServices {

    //MARK: Properties

    private let recipesURL = URL(string: "https://api.edamam.com/search?")!

    private var recipesSession = URLSession(configuration: .default)
    private var task: URLSessionDataTask?

    init(recipesSession: URLSession){
        self.recipesSession = recipesSession
    }

    private func createRecipesRequest(with
        ingredients: String) -> URLComponents {
        var component = URLComponents(url: recipesURL, resolvingAgainstBaseURL: true)

        component?.queryItems = [URLQueryItem(name: "q", value: "\(ingredients)"),
                                 URLQueryItem(name: "app_key", value: "1ca6fa53868439f0dff48a62bed5b933"),
                                 URLQueryItem(name: "app_id", value: "ae5de728")]
        return component!
    }

    func getRecipes(with ingredients: String, callback: @escaping (Bool, Recipes?) -> Void) {
        let request = createRecipesRequest(with: ingredients)
        task?.cancel()
        task = recipesSession.dataTask(with: request.url!) { (data, response, error) in
            DispatchQueue.main.async {

                guard let data = data, error == nil else {
                    callback(false, nil)
                    return
                }

                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false, nil)
                    return
                }

                guard let recipes = try? JSONDecoder().decode(Recipes.self, from: data) else {
                    callback(false, nil)
                    return
                }

                callback(true, recipes)

            }
        }
        task?.resume()
    }
}
