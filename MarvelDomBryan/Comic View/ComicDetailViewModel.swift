//
//  ComicDetailViewModel.swift
//  MarvelDomBryan
//
//  Created by Dom Bryan on 23/02/2020.
//  Copyright © 2020 Dom Bryan. All rights reserved.
//

import UIKit

protocol ComicDetailViewable {
    func comicTitle() -> String
    func comicDescription() -> String
    func comicImage(_ completion: @escaping (UIImage?) -> Void)
}

final class ComicDetailViewModel: ComicDetailViewable {
    private let comic: Comics
    private let imageService: ImageService
    
    init(comic: Comics, imageService: ImageService = MarvelImageService()) {
        self.comic = comic
        self.imageService = imageService
    }
    
    func comicTitle() -> String {
        comic.title
    }
    
    func comicDescription() -> String {
        comic.description ?? "No Description"
    }
    
    func comicImage(_ completion: @escaping (UIImage?) -> Void) {
        guard let url = comic.imageURL else { return }
        imageService.fetchImage(request: URLRequest(url: url)) { (image, error) in
            completion(image)
        }
    }
}
