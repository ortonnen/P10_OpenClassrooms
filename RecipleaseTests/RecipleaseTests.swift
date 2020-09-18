//
//  RecipleaseTests.swift
//  RecipleaseTests
//
//  Created by Nathalie Ortonne on 17/09/2020.
//  Copyright © 2020 Nathalie Ortonne. All rights reserved.
//

import XCTest
@testable import Reciplease

class RecipleaseTests: XCTestCase {

    //MARK: RecipesServiceTest

    func testGetTranslationShouldPostFailedCallback() {

        let recipesService = RecipesServices(
            recipesSession: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))

        let expectation = XCTestExpectation(description: "Wait for queue change.")

        recipesService.getRecipes(with: "chicken") { (success, recipes) in

            XCTAssertFalse(success)
            XCTAssertNil(recipes)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetTranslateShouldPostFailedCallbackIfNoData() {

        let recipesService = RecipesServices(
            recipesSession: URLSessionFake(data: nil, response: nil, error: nil))

        let expectation = XCTestExpectation(description: "Wait for queue change.")

        recipesService.getRecipes(with: "chicken") { (success, recipes) in

            XCTAssertFalse(success)
            XCTAssertNil(recipes)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetTranslateShouldPostFailedCallbackIfIncorrectResponse() {

        let recipesService = RecipesServices(
            recipesSession: URLSessionFake(data: FakeResponseData.recipesCorrectData, response: FakeResponseData.responseKO, error: nil))

        let expectation = XCTestExpectation(description: "Wait for queue change.")

        recipesService.getRecipes(with: "chicken") { (success, recipes) in

            XCTAssertFalse(success)
            XCTAssertNil(recipes)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetTranslateShouldPostFailedCallbackIfIncorrectData() {

        let recipesService = RecipesServices(
            recipesSession: URLSessionFake(data: FakeResponseData.incorrectData, response: FakeResponseData.responseOK, error: nil))

        let expectation = XCTestExpectation(description: "Wait for queue change.")

        recipesService.getRecipes(with: "chicken") { (success, recipes) in

            XCTAssertFalse(success)
            XCTAssertNil(recipes)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetTranslateShouldPostSuccessCallBackIfNoErrorAndCorrectData() {

        let recipesService = RecipesServices(
            recipesSession: URLSessionFake(data: FakeResponseData.recipesCorrectData, response: FakeResponseData.responseOK, error: nil))

        let expectation = XCTestExpectation(description: "Wait for queue change.")

        recipesService.getRecipes(with: "chicken") { (success, recipes) in

            XCTAssertTrue(success)
            XCTAssertNotNil(recipes)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

}
