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
    
    var fakeResponseData: FakeResponse!
    var recipeService: RecipesServices {
        return RecipesServices(session: AlamofireSessionFake(fakeResponse: fakeResponseData))
    }
    
    //MARK: RecipesServiceTest
    func testGetRecipeShouldGetFailedCallbackIfErrorAndIncorrectData() {
        fakeResponseData = FakeResponse(response: FakeResponseData.responseOK, data: FakeResponseData.incorrectData, error: FakeResponseData.error)
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        recipeService.getRecipes(with: ["lemon"]) { (result) in
            
            guard case .failure(let error) = result else {
                XCTFail("test GetRecipe Should Post Failed Callback failed")
                return
            }
            expectation.fulfill()
            XCTAssertNotNil(error)
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func testGetRecipeShouldCallBackErrorIfBadResponseAndIncorrectData() {
        fakeResponseData = FakeResponse(response: FakeResponseData.responseKO, data: FakeResponseData.incorrectData, error: nil)
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        recipeService.getRecipes(with: ["lemon"]) { (result) in
            
            guard case .failure(let error) = result else {
                XCTFail("test GetRecipe Should Post Failed Callback failed")
                return
            }
            expectation.fulfill()
            XCTAssertNotNil(error)
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func testGetRecipeSouldFailedIfNoData() {
        fakeResponseData = FakeResponse(response: FakeResponseData.responseOK, data: nil, error: nil)
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        recipeService.getRecipes(with: ["lemon"]) { (result) in
            
            guard case .failure(let error) = result else {
                XCTFail("test GetRecipe Should Post Failed Callback failed")
                return
            }
            expectation.fulfill()
            XCTAssertNotNil(error)
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func testGetRecipeSouldFailedIfErrorWithCorrectDataResponse() {
        fakeResponseData = FakeResponse(response: FakeResponseData.responseOK, data: FakeResponseData.recipesCorrectData, error: FakeResponseData.error)
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        recipeService.getRecipes(with: ["lemon"]) { (result) in
            
            guard case .failure(let error) = result else {
                XCTFail("test GetRecipe Should Post Failed Callback failed")
                return
            }
            expectation.fulfill()
            XCTAssertNotNil(error)
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func testGetRecipeSouldGetSuccessIfCorrectDataResponseAndNoError() {
        fakeResponseData = FakeResponse(response: FakeResponseData.responseOK, data: FakeResponseData.recipesCorrectData, error: nil)
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        recipeService.getRecipes(with: ["lemon"]) { (result) in
            
            guard case .success(let recipe) = result else {
                XCTFail("Test getData method with undecodable data failed.")
                return
            }
            XCTAssertTrue(recipe.hits[0].recipe.label == "Lemon Confit")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
}
