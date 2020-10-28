//
//  RecipleaseTests.swift
//  RecipleaseTests
//
//  Created by Nathalie Ortonne on 17/09/2020.
//  Copyright © 2020 Nathalie Ortonne. All rights reserved.
//

import XCTest
import Alamofire
@testable import Reciplease

class RecipleaseTests: XCTestCase {

    //MARK: RecipesServiceTest

    func testGetRecipeShouldPostFailedCallback() {

        let session = AlamofireSessionFake(fakeResponse: FakeResponse(response: nil, data: nil))
        let recipeService = RecipesServices(session: session)

        let expectation = XCTestExpectation(description: "Wait for queue change.")

        recipeService.getRecipes(with: ["lemon"]) { (result) in

            guard case .failure(let error) = result else {
                XCTFail("test GetRecipe Should Post Failed Callback failed")
                return
            }
            expectation.fulfill()
            XCTAssertNotNil(error)
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetRecipeShouldPostFailedCallbackIfNoData() {

        let session = AlamofireSessionFake(fakeResponse: FakeResponse(response: FakeResponseData.responseOK, data: FakeResponseData.incorrectData))
        let recipeService = RecipesServices(session: session)
        let expectation = XCTestExpectation(description: "Wait for queue change.")

        recipeService.getRecipes(with: ["lemon"]) { result in
            guard case .failure(let error) = result else {
                XCTFail("test GetRecipe Should Post Failed Callback If No Data failed.")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetRecipeShouldPostFailedCallbackIfIncorrectResponse() {

        let session = AlamofireSessionFake(fakeResponse: FakeResponse(response: FakeResponseData.responseKO, data: FakeResponseData.recipesCorrectData))
        let recipeService = RecipesServices(session: session)
        let expectation = XCTestExpectation(description: "Wait for queue change.")

        recipeService.getRecipes(with: ["lemon"]) { result in
            guard case .failure(let error) = result else {
                XCTFail("test GetRecipe Should Post Failed Callback If Incorrect Response failed")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetTranslateShouldPostSuccessCallBackIfNoErrorAndCorrectData() {

        let session = AlamofireSessionFake(fakeResponse: FakeResponse(response: FakeResponseData.responseOK, data: FakeResponseData.recipesCorrectData))
        let recipeService = RecipesServices(session: session)
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        recipeService.getRecipes(with: ["Lemon"]) { result in
            guard case .success(let data) = result else {
                XCTFail("Test getData method with undecodable data failed.")
                return
            }
            XCTAssertTrue(data.hits[0].recipe.label == "Lemon Confit")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
}
