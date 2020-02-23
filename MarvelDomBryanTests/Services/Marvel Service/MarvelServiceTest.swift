//
//  MarvelServiceTest.swift
//  MarvelDomBryanTests
//
//  Created by Dom Bryan on 23/02/2020.
//  Copyright © 2020 Dom Bryan. All rights reserved.
//

import XCTest

@testable import MarvelDomBryan

class MarvelServiceTests: XCTestCase {

    var subject: MarvelService!
    var mockNetworkManager: MockNetworkManager!
    
    override func setUp() {
        mockNetworkManager = MockNetworkManager()
        subject = MarvelService(networkManager: mockNetworkManager)
    }

    override func tearDown() {
        subject = nil
    }
    
    func test_FetchComicsSucceedsReturnsMarvelResponseModel() {
        let data = MarvelServiceTests.mockData
        
        mockNetworkManager.data = data
        var result: Result<MarvelResponseModel, MarvelServiceError>?
        let expectation = XCTestExpectation(description: #function)
        subject.fetchComics { fetchedResult in
            result = fetchedResult
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.1)
   
        switch result {
        case .success(let responseModel):
            XCTAssertNotNil(responseModel)
        default:
            XCTFail()
        }
    }
    
    func test_FetchComicsGetsIncorrectDataDoesSomething() {
        let incorrectData = Data([0,1,2,3])
        mockNetworkManager.data = incorrectData
        mockNetworkManager.error = nil

        var result: Result<MarvelResponseModel, MarvelServiceError>?
        let expectation = XCTestExpectation(description: #function)
        subject.fetchComics { fetchedResult in
            result = fetchedResult
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.1)

        switch result {
        case .failure(let error):
            XCTAssertNotNil(error)
            XCTAssertEqual(error, MarvelServiceError.jsonError)
        default:
            XCTFail()
        }
    }
    
    func test_FetchComicsFailsReturnsNil() {
        mockNetworkManager.data = nil
        mockNetworkManager.error = nil
        
        var result: Result<MarvelResponseModel, MarvelServiceError>?
        let expectation = XCTestExpectation(description: #function)
        subject.fetchComics { fetchedResult in
            result = fetchedResult
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.1)
        
        switch result {
        case .failure(let error):
            XCTAssertNotNil(error)
            XCTAssertEqual(error, MarvelServiceError.noData)
        default:
            XCTFail()
        }
    }
    
    func test_FetchComicsFailsWithBadRequestReturnsNil() {
        mockNetworkManager.data = nil
        mockNetworkManager.error = TestError.test
        
        var result: Result<MarvelResponseModel, MarvelServiceError>?
        let expectation = XCTestExpectation(description: #function)
        subject.fetchComics { fetchedResult in
            result = fetchedResult
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.1)
        
        switch result {
        case .failure(let error):
            XCTAssertNotNil(error)
            XCTAssertEqual(error, MarvelServiceError.networkRequestError)
        default:
            XCTFail()
        }
    }
}

class MockNetworkManager: NetworkManaging {
    
    var data: Data?
    var error: Error?
    
    var fetchCalled: Bool = false
    func fetch(request: URLRequest, completeOnMainThread: Bool, completion: @escaping ServiceCompletion) -> URLSessionDataTaskProtocol {
        fetchCalled = true
        
        let data = self.data
        let error = self.error
        
        let dataTask = MockURLSessionDataTask {
            completion(data, nil, error)
        }
        dataTask.resume()
        return dataTask
    }
}

enum TestError: Error {
    case test
}

extension MarvelServiceTests {
    static var mockData: Data {
        let bundle = Bundle(for: self)
        let path = bundle.path(forResource: "comics", ofType: "json")!
        return FileManager().contents(atPath: path)!
    }
}
