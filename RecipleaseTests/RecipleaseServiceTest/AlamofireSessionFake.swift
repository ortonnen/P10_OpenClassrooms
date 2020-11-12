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
}


class AlamofireSessionFake: AlamoSession {

    // MARK: - Properties

    private let fakeResponse: FakeResponse

    // MARK: - Initializer

    init(fakeResponse: FakeResponse) {
        self.fakeResponse = fakeResponse
    }

    //MARK: Methode

    func request(with url: URL, callBack : @escaping (AFDataResponse<Any>) -> Void) {
        guard let httpResponse = fakeResponse.response else {return}
        guard let requestData = fakeResponse.data else {return}
        let urlRequest = URLRequest(url: URL(string: "https://www.apple.com")!)
//        let response = try? JSONSerialization.data(withJSONObject: requestData, options: .fragmentsAllowed)

        let response = JSONResponseSerializer()
        let result = try? response.serialize(request: urlRequest, response: httpResponse, data: requestData, error: nil)
        
        callBack(AFDataResponse<Any>(request: urlRequest, response: httpResponse, data: requestData, metrics: .none, serializationDuration: .zero, result: result as! Result<Any, AFError>))
    }
}


