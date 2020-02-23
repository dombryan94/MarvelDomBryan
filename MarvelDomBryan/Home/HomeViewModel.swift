//
//  HomeViewModel.swift
//  MarvelDomBryan
//
//  Created by Dom Bryan on 22/02/2020.
//  Copyright © 2020 Dom Bryan. All rights reserved.
//

import Foundation

protocol HomeViewModelProtocol {
    var comics: [Comics]? { get }
    var filteredComics: [Comics] { get }
    func fetchComics(searchText: String?, then completion: @escaping (HomeTableViewState) -> Void)
    func filterContentForSearchText(_ searchText: String, completion: @escaping (HomeTableViewState) -> Void)
}

extension HomeViewModelProtocol {
    func fetchComics(searchText: String? = nil, then completion: @escaping (HomeTableViewState) -> Void) {
        fetchComics(searchText: searchText, then: completion)
    }
}

class HomeViewModel: HomeViewModelProtocol {
    var comics: [Comics]?
    var filteredComics: [Comics] = []
    
    private let marvelService: MarvelServicable
    
    init(marvelService: MarvelServicable) {
        self.marvelService = marvelService
    }
    
    func fetchComics(searchText: String?, then completion: @escaping (HomeTableViewState) -> Void) {
        marvelService.fetchComics(searchText: searchText) { result in
            switch result {
            case .success(let comics):
                if searchText != nil {
                    self.filteredComics = comics.data?.results ?? []
                } else {
                    self.comics = comics.data?.results
                }
                completion(.loaded)
            case .failure(let error):
                completion(.failed)
                print(error)
            }
        }
    }
    
    func filterContentForSearchText(_ searchText: String, completion: @escaping (HomeTableViewState) -> Void) {
        if searchText == "" { return }
        fetchComics(searchText: searchText, then: completion)
    }
}
