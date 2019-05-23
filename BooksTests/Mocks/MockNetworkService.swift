//
//  MockNetworkService.swift
//  BooksTests
//
//  Created by Spencer Prescott on 5/23/19.
//  Copyright © 2019 Spencer Prescott. All rights reserved.
//

import Foundation
@testable import Books

final class MockNetworkRequest: NetworkRequest {
    func executeRequest() {}
    func cancelRequest() {}
}

final class MockNetworkService: NetworkServicing {
    private let data: Data
    
    init(data: Data) {
        self.data = data
    }
    
    func buildRequest(url: URL, resultHandler: @escaping (Result<Data, NetworkError>) -> Void) -> NetworkRequest {
        resultHandler(.success(result: data))
        return MockNetworkRequest()
    }
}
