//
//  MarvelService.swift
//  MarvelDomBryan
//
//  Created by Dom Bryan on 22/02/2020.
//  Copyright © 2020 Dom Bryan. All rights reserved.
//

import Foundation

typealias MarvelServiceCompletion = (_ result: Result<MarvelResponseModel, MarvelServiceError>) -> Void

enum MarvelServiceError: Error {
    case networkRequestError, jsonError, noData
}

final class MarvelService {
    
    private let networkManager: NetworkManaging
    
    init(networkManager: NetworkManaging = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func fetchComics(searchText: String? = nil, completion: @escaping MarvelServiceCompletion) {
        if let url = Foundation.URL(string: URLs.marvelComics(searchText: searchText)) {
            let request = URLRequest(url: url)
            networkManager.fetch(request: request, completeOnMainThread: false) { (data, response, error) in
                if error != nil {
                    completion(Result.failure(MarvelServiceError.networkRequestError))
                    return
                }
                if let data = data {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    do {
                        let model = try decoder.decode(MarvelResponseModel.self, from: data)
                        DispatchQueue.main.async {
                            completion(Result.success(model))
                        }
                    } catch let error {
                        print(error)
                        completion(Result.failure(MarvelServiceError.jsonError))
                    }
                } else {
                    completion(Result.failure(MarvelServiceError.noData))
                }
            }
        }
    }
}
