//
//  FakeResponseData.swift
//  RecipleaseTests
//
//  Created by Nathalie Ortonne on 18/09/2020.
//  Copyright © 2020 Nathalie Ortonne. All rights reserved.
//

import Foundation

class FakeResponseData {
    // MARK: - Data

    static var recipesCorrectData: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Recipes", withExtension: "json")!

        return try! Data(contentsOf: url)
    }

    static let incorrectData = "error".data(using: .utf8)!

    // MARK: - Response
    static let responseOK = HTTPURLResponse(
        url: URL(string: "https://google.com")!,
        statusCode: 200, httpVersion: nil, headerFields: nil)!

    static let responseKO = HTTPURLResponse(
        url: URL(string: "https://google.com")!,
        statusCode: 500, httpVersion: nil, headerFields: nil)!

    // MARK: - Error
    class FakeError: Error {}
    static let error = FakeError()
}
