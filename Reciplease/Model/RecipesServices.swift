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
    
    //MARK: Properties
    private let recipesURL = URL(string: "https://api.edamam.com/search?")!
    private let apikey = "1ca6fa53868439f0dff48a62bed5b933"
    private let apiId = "ae5de728"

    func getRecipes(with ingredients: [String], callback: @escaping (Swift.Result<Recipes, NetworkError>) -> Void) {

        let ingredient = ingredients.joined(separator: ",")

        guard let url = URL(string: "\(recipesURL)&q=\(ingredient)))&app_id=\(apiId)&app_key=\(apikey)") else { return }

       AF.request(url).responseJSON { (dataResponse) in
            guard dataResponse.error == nil else {
                callback(.failure(.error))
                return
            }
            guard dataResponse.response?.statusCode == 200 else {
                    callback(.failure(.statusCodeError))
                    return
                }
            guard dataResponse.data != nil else {
                callback(.failure(.noData))
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


