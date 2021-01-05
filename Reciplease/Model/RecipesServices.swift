//
//  RecipesServices.swift
//  Reciplease
//
//  Created by Nathalie Ortonne on 18/09/2020.
//  Copyright © 2020 Nathalie Ortonne. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage

enum NetworkError: Error {
    case error
    case statusCodeError
    case noData
    case decodeDataError
}

class RecipesServices {

    //MARK: - Properties
    private let recipesURL = URL(string: "https://api.edamam.com/search?")!
    private let apikey = "APIKEY"
    private let apiId = "APIID"

    private let session: AlamoSession

    // MARK: - Initialization

    init(session: AlamoSession = RecipeSession()) {
        self.session = session
    }

    ///network call method
    func getRecipes(with ingredients: [String], callback: @escaping (Swift.Result<Recipes, NetworkError>) -> Void) {

        let ingredient = ingredients.joined(separator: ",")

        guard let url = URL(string: "\(recipesURL)&q=\(ingredient)))&app_id=\(apiId)&app_key=\(apikey)&from=0&to=10") else { return }

        session.request(with: url) { (dataResponse) in

            guard dataResponse.data != nil else {
                callback(.failure(.noData))
                return
            }
            guard dataResponse.error == nil else {
                callback(.failure(.error))
                return
            }
            do {
                let responseJSON = try JSONDecoder().decode(Recipes.self, from: dataResponse.data!)
                callback(.success(responseJSON))
            } catch {
                callback(.failure(.decodeDataError))
            }
        }
    }
}


