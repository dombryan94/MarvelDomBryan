//
//  NetworkManager.swift
//  MarvelDomBryan
//
//  Created by Dom Bryan on 22/02/2020.
//  Copyright © 2020 Dom Bryan. All rights reserved.
//

import Foundation

typealias ServiceCompletion = (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void

protocol NetworkManaging {
    @discardableResult func fetch(request: URLRequest, completeOnMainThread: Bool, completion: @escaping ServiceCompletion) -> URLSessionDataTaskProtocol
}

final class NetworkManager: NetworkManaging {
    
    private let session: URLSessionProtocol
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    @discardableResult func fetch(request: URLRequest, completeOnMainThread: Bool, completion: @escaping ServiceCompletion) -> URLSessionDataTaskProtocol {
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            self.log(data, response, error)
            if completeOnMainThread {
                DispatchQueue.main.async {
                    completion(data, response, error)
                }
            } else {
                completion(data, response, error)
            }
        }
        dataTask.resume()
        return dataTask
    }
    
    func log(_ data: Data?, _ response: URLResponse?, _ error: Error?) {
        print("--- Network Responded---")
        print("  Data: \(String(describing: data))")
        print("  Reponse: \(String(describing: response?.url))")
        print("  Error: \(String(describing: error))")
    }
}
