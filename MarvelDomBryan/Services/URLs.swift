//
//  URLs.swift
//  MarvelDomBryan
//
//  Created by Dom Bryan on 22/02/2020.
//  Copyright © 2020 Dom Bryan. All rights reserved.
//

import Foundation

struct URLs {
    private static let apiKey: String = "3d3ce5daa8ec0f7c17afc52bb68f15f7"
    private static let hash: String = "a45bdb0bf57b06e72ad4c2c5854e2843"
    private static let limit: Int = 25
    private static let offset: Int = 0
    
    static let baseURL = "https://gateway.marvel.com/v1/public/comics?ts=1&apikey=\(apiKey)&hash=\(hash)&limit=\(limit)&offset=\(offset)"
    
    static func marvelComics(searchText: String? = nil) -> String {
        if let search = searchText {
            let url = baseURL + "&title=\(search)" + "&orderBy=-onsaleDate"
            return url
        }
        return baseURL
    }
}
