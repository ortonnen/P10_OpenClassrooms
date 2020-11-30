//
//  RecipesSession.swift
//  Reciplease
//
//  Created by Nathalie Ortonne on 16/10/2020.
//  Copyright © 2020 Nathalie Ortonne. All rights reserved.
//

import Foundation
import Alamofire

// MARK: Protocol AlamoSession
protocol AlamoSession {
    func request(with url: URL, callBack: @escaping (AFDataResponse<Any>) -> Void)
}

// MARK: RecipeSession
class RecipeSession: AlamoSession {
    func request(with url: URL, callBack: @escaping (AFDataResponse<Any>) -> Void) {
        AF.request(url)
            .validate(statusCode: 200 ..< 400)
            .responseJSON { (data) in
                callBack(data)
            }
    }
}

