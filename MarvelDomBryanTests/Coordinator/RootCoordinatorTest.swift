//
//  RootCoordinatorTest.swift
//  MarvelDomBryanTests
//
//  Created by Dom Bryan on 23/02/2020.
//  Copyright © 2020 Dom Bryan. All rights reserved.
//

import XCTest

@testable import MarvelDomBryan

class RootCoordinatorTests: XCTestCase {
    
    var subject: RootCoordinator!
    var navigationController: UINavigationController!

    override func setUp() {
        navigationController = UINavigationController()
        subject = RootCoordinator(navigationController: navigationController)
    }

    override func tearDown() {
        subject = nil
    }

    func test_Start_PresentsHomeController() {
        subject.start()
        let correctViewController = navigationController.topViewController as? HomeController
        XCTAssertNotNil(correctViewController)
    }
    
    func test_DidSelectCalledWithValidComic_PresentsDetailsVC() {
        let mockComic = Comics(id: 0,
                               title: "Spooder Mon",
                               issueNumber: 10,
                               description: "Big spooder",
                               urls: [],
                               thumbnail: Thumbnail(path: "path", thumbnailExtension: .jpg))
        subject.didSelect(comic: mockComic)
        let correctViewController = navigationController.topViewController as? ComicDetailController
        XCTAssertNotNil(correctViewController)
    }
    
    
    func test_DidSelectCalledWithNilComic_DoesNothing() {
        subject.didSelect(comic: nil)
        let correctViewController = navigationController.topViewController as? ComicDetailController
        XCTAssertNil(correctViewController)
    }
}
