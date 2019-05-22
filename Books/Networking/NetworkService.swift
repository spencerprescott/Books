//
//  NetworkService.swift
//  Books
//
//  Created by Spencer Prescott on 5/21/19.
//  Copyright © 2019 Spencer Prescott. All rights reserved.
//

import Foundation

enum NetworkError: LocalizedError {
    case cancelled
    case unknown
    case generic(message: String)
    
    var errorDescription: String? {
        switch self {
        case .generic(let message):
            return message
        case .unknown:
            return "Unknown Error"
        case .cancelled:
            return nil
        }
    }
}

protocol NetworkServicing: class {
    func buildRequest(url: URL, resultHandler: @escaping (Result<Data, NetworkError>) -> Void) -> NetworkRequest
}

final class NetworkService: NetworkServicing {
    static let shared = NetworkService()
    private let session: URLSession
    
    init() {
        self.session = URLSession(configuration: .default)
    }
    
    func buildRequest(url: URL, resultHandler: @escaping (Result<Data, NetworkError>) -> Void) -> NetworkRequest {
        let task = session.dataTask(with: url) { data, _, error in
            if let error = error {
                if (error as NSError).code == NSURLErrorCancelled {
                    resultHandler(.failure(error: .cancelled))
                } else {
                    resultHandler(.failure(error: .generic(message: error.localizedDescription)))
                }
            } else if let data = data {
                resultHandler(.success(result: data))
            } else {
                resultHandler(.failure(error: .unknown))
            }
        }
        
        return task
    }
}
