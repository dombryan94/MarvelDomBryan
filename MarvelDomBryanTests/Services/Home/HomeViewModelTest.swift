//
//  HomeViewModelTest.swift
//  MarvelDomBryanTests
//
//  Created by Dom Bryan on 23/02/2020.
//  Copyright © 2020 Dom Bryan. All rights reserved.
//

import XCTest

@testable import MarvelDomBryan

class HomeViewModelTest: XCTestCase {
    var subject: HomeViewModelProtocol!
    var mockMarvelService: MockMarvelService!
    
    override func setUp() {
        mockMarvelService = MockMarvelService()
        subject = HomeViewModel(marvelService: mockMarvelService)
    }
    
    override func tearDown() {
        subject = nil
    }
    
    func test_FetchComicsSuceeds_RendersLoaded() {
        var completedState: HomeTableViewState = .loaded
        
        let data = MarvelServiceTests.mockData
        let response = MarvelResponseModel.marvelReponseModel(for: data)
        mockMarvelService.modelToReturn = response
        
        let expectation = XCTestExpectation(description: #function)
        subject.fetchComics { state in
            completedState = state
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2.0)
        
        XCTAssertTrue(mockMarvelService.fetchComicsCalled)
        XCTAssertEqual(completedState, .loaded)
    }
    
    func test_FetchComicsFails_RendersFailed() {
        var completedState: HomeTableViewState = .loaded
        
        mockMarvelService.modelToReturn = nil
        
        let expectation = XCTestExpectation(description: #function)
        subject.fetchComics { state in
            completedState = state
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2.0)
        
        XCTAssertTrue(mockMarvelService.fetchComicsCalled)
        XCTAssertEqual(completedState, .failed)
    }
}

class MockMarvelService: MarvelServicable {

    var fetchComicsCalled: Bool = false
    var modelToReturn: MarvelResponseModel?

    func fetchComics(searchText: String? = nil, completion: @escaping MarvelServiceCompletion) {
        fetchComicsCalled = true
        if let model = self.modelToReturn {
            completion(.success(model))
        } else {
            completion(.failure(MarvelServiceError.noData))
        }
    }
}

extension MarvelResponseModel {
    static func marvelReponseModel(for data: Data) -> MarvelResponseModel {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let model = try? decoder.decode(MarvelResponseModel.self, from: data)
        return model!
    }
}
