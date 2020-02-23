//
//  ImageService.swift
//  MarvelDomBryan
//
//  Created by Dom Bryan on 22/02/2020.
//  Copyright © 2020 Dom Bryan. All rights reserved.
//

import UIKit

typealias ImageServiceCompletion = (_ image: UIImage?, _ error: Error?) -> Void

protocol ImageService {
    func fetchImage(request: URLRequest, completion: @escaping ImageServiceCompletion)
}
