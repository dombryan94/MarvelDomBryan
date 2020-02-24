//
//  MarvelResponseModel.swift
//  MarvelDomBryan
//
//  Created by Dom Bryan on 22/02/2020.
//  Copyright © 2020 Dom Bryan. All rights reserved.
//

import Foundation

// MARK: - Welcome
struct MarvelResponseModel: Codable {
    let data: DataClass?
}

// MARK: - DataClass
struct DataClass: Codable {
    let offset, limit, total, count: Int
    let results: [Comics]
}

// MARK: - Result
struct Comics: Codable {
    let id: Int
    let title: String
    let issueNumber: Int
    let description: String?
//    let modified: Date
//    let format: String
//    let pageCount: Int
//    let resourceURI: String
    let urls: [URLElement]
//    let series: Series
//    let variants: [Series]
//    let dates: [DateElement]
//    let prices: [Price]
    let thumbnail: Thumbnail
//    let images: [Thumbnail]
//    let creators: Creators
//    let characters: Characters
//    let stories: Stories
//    let events: Characters
}

// MARK: - Characters
struct Characters: Codable {
    let available: Int
    let collectionURI: String
    let items: [Series]
    let returned: Int
}

// MARK: - Series
struct Series: Codable {
    let resourceURI: String
    let name: String
}

// MARK: - Creators
struct Creators: Codable {
    let available: Int
    let collectionURI: String
    let items: [CreatorsItem]
    let returned: Int
}

// MARK: - CreatorsItem
struct CreatorsItem: Codable {
    let resourceURI: String
    let name, role: String
}

// MARK: - DateElement
struct DateElement: Codable {
    let type: DateType
    let date: Date
}

enum DateType: String, Codable {
    case digitalPurchaseDate
    case focDate
    case onsaleDate
    case unlimitedDate
}

// MARK: - Thumbnail
struct Thumbnail: Codable {
    let path: String
    let thumbnailExtension: Extension
    
    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}

enum Extension: String, Codable {
    case jpg = "jpg"
}

// MARK: - Price
struct Price: Codable {
    let type: PriceType
    let price: Double
}

enum PriceType: String, Codable {
    case digitalPurchasePrice
    case printPrice
}

// MARK: - Stories
struct Stories: Codable {
    let available: Int
    let collectionURI: String
    let items: [StoriesItem]
    let returned: Int
}

// MARK: - StoriesItem
struct StoriesItem: Codable {
    let resourceURI: String
    let name: String
    let type: String
}


// MARK: - URLElement
struct URLElement: Codable {
    let type: URLType
    let url: String
}

enum URLType: String, Codable {
    case detail
    case inAppLink
    case purchase
    case reader
}

extension Comics {
    var imageURL: Foundation.URL? {
        let urlString = String("\(thumbnail.path).\(thumbnail.thumbnailExtension.rawValue)")
        return Foundation.URL(string: urlString)
    }
    
    var descriptionURL: Foundation.URL? {
        let descriptionURL = urls.filter { $0.type == .detail }
        guard let urlString = descriptionURL.first?.url else { return nil }
        return Foundation.URL(string: urlString)
    }
}
