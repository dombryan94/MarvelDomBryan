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

    func test_CachingImage_LoadingImage_Works() {
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
        let bundle = Bundle(for: self)
        guard let path = bundle.path(forResource: "test", ofType: "png") else { return nil}
        return FileManager().contents(atPath: path)!
    }
}
