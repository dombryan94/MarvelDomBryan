//
//  ImageCacheTest.swift
//  MarvelDomBryanTests
//
//  Created by Dom Bryan on 23/02/2020.
//  Copyright © 2020 Dom Bryan. All rights reserved.
//

import XCTest

@testable import MarvelDomBryan

class ImageCacheTests: XCTestCase {

    var subject: ImageCacher!
    
    override func setUp() {
        subject = ImageCache.shared
    }

    override func tearDown() {
        subject = nil
    }

    ///I have excluded this test as in Xcode beta 11.4 I was having issues retrieving an image from bundle. Something to look into with more time.
    func xtest_CachingImage_LoadingImage_Works() {
        guard let imageData = ImageCacheTests.mockImageData else {
            XCTFail("No image in bundle")
            return
        }
        let testImage = UIImage(data: imageData)!
        let testURL = URL(string: "test")!
        subject.cache(testImage, for: testURL)
        
        let cachedImage = subject.loadImage(for: testURL)
        
        XCTAssertEqual(testImage, cachedImage)
    }
}

extension ImageCacheTests {
    static var mockImageData: Data? {
        let bundle = Bundle(for: ImageCacheTests.self)
        guard let path = bundle.url(forResource: "test", withExtension: "png", subdirectory: "TestData") else { return nil }
        do {
            return try Data(contentsOf: path)
        } catch let error {
            print(error)
            return nil
        }
    }
}
