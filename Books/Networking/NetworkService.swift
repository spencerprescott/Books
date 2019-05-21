//
//  NetworkService.swift
//  Books
//
//  Created by Spencer Prescott on 5/21/19.
//  Copyright © 2019 Spencer Prescott. All rights reserved.
//

import Foundation

struct NetworkError: LocalizedError {
    let errorDescription: String?
}

protocol NetworkServicing: class {
    func executeRequest(url: URL, resultHandler: @escaping (Result<Data, Error>) -> Void)
}

final class NetworkService: NetworkServicing {
    static let shared = NetworkService()
    private let session: URLSession
    
    init() {
        self.session = URLSession(configuration: .default)
    }
    
    func executeRequest(url: URL, resultHandler: @escaping (Result<Data, Error>) -> Void) {
        let task = session.dataTask(with: url) { data, _, error in
            if let error = error {
                resultHandler(.failure(error: error))
            } else if let data = data {
                resultHandler(.success(result: data))
            } else {
                resultHandler(.failure(error: NetworkError(errorDescription: "Unknown Error")))
            }
        }
        
        task.resume()
    }
}
