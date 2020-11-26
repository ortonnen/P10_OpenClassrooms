//
//  URLSessionFake.swift
//  RecipleaseTests
//
//  Created by Nathalie Ortonne on 18/09/2020.
//  Copyright © 2020 Nathalie Ortonne. All rights reserved.
//

import Foundation
import Alamofire
@testable import Reciplease

struct FakeResponse {
    var response: HTTPURLResponse?
    var data: Data?
    var error: AFError?
}

class AlamofireSessionFake: AlamoSession {

    // MARK: - Properties
    private let fakeResponse: FakeResponse

    // MARK: - Initializer
    init(fakeResponse: FakeResponse) {
        self.fakeResponse = fakeResponse
    }

    //MARK: - Methods
    func request(with url: URL, callBack: @escaping (AFDataResponse<Any>) -> Void) {
        guard let httpResponse = fakeResponse.response else {
            return
        }
        guard let requestData = fakeResponse.data else {
            callBack(.init(request: nil, response: nil, data: nil, metrics: nil, serializationDuration: 0.0, result: .failure(.explicitlyCancelled)))
            return
        }
        let urlRequest = URLRequest(url: url)

        let object = try? JSONDecoder().decode(Recipe.self, from: requestData)
        let result: Result<Any,AFError> = fakeResponse.error == nil ? .success(object as Any) : .failure(fakeResponse.error ?? AFError.explicitlyCancelled)

        let dataResponse = AFDataResponse(request: urlRequest, response: httpResponse, data: requestData, metrics: nil, serializationDuration: 0.0, result: result)

        callBack(dataResponse)
    }
}

