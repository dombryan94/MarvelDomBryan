//
//  NetworkManagerTest.swift
//  MarvelDomBryanTests
//
//  Created by Dom Bryan on 23/02/2020.
//  Copyright © 2020 Dom Bryan. All rights reserved.
//

import XCTest

@testable import MarvelDomBryan

class NetworkManagerTests: XCTestCase {
    
    var subject: NetworkManaging!
    var mockSession: MockURLSession!
    let request = URLRequest(url: URL(string: "Test")!)
    let mockData = Data([0,1,0,1])

    override func setUp() {
        mockSession = MockURLSession()
        subject = NetworkManager(session: mockSession)
    }

    override func tearDown() {
        subject = nil
    }

    func test_NetworkManagerFetchCalled_StartsARequest() {
        let dataTask = subject.fetch(request: request, completeOnMainThread: false) { (_, _, _) in }
        XCTAssertTrue((dataTask as! MockURLSessionDataTask).resumeCalled)
    }
    
    func test_NetworkManagerFetchCalled_DataReceived_CallsCompletionWithData() {
        mockSession.data = mockData

        var result: Data?
        subject.fetch(request: request, completeOnMainThread: false) { (data, _, _) in
            result = data
        }
        XCTAssertEqual(result, mockData)
    }
    
    func test_NetworkManagerFetchCalled_NoDataReceived_CallsCompletionWithNil() {
        mockSession.data = nil

        var result: Data? = mockData
        subject.fetch(request: request, completeOnMainThread: false) { (data, _, _) in
            result = data
        }
        XCTAssertNil(result)
    }
}

// MARK: Mocking

class MockURLSession: URLSessionProtocol {
    var data: Data?
    var error: Error?

    func dataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
        let data = self.data
        let error = self.error
        
        return MockURLSessionDataTask(closure: {
            completionHandler(data, nil, error)
        })
    }
}

class MockURLSessionDataTask: URLSessionDataTaskProtocol {
    
    private let closure: () -> Void

    init(closure: @escaping () -> Void) {
        self.closure = closure
    }
    
    var resumeCalled: Bool = false
    func resume() {
        resumeCalled = true
        closure()
    }
}
