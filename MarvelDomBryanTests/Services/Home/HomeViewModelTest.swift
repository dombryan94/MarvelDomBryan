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
    var mockMarvelService: MarvelServicable!
    
    override func setUp() {
        mockMarvelService = MockMarvelService()
        subject = HomeViewModel(marvelService: mockMarvelService)
    }
    
    override func tearDown() {
        subject = nil
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
