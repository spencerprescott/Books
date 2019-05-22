//
//  NetworkRequest.swift
//  Books
//
//  Created by Spencer Prescott on 5/21/19.
//  Copyright © 2019 Spencer Prescott. All rights reserved.
//

import Foundation

protocol NetworkRequest {
    func executeRequest()
    func cancelRequest()
}

extension URLSessionDataTask: NetworkRequest {
    func executeRequest() {
        resume()
    }
    
    func cancelRequest() {
        cancel()
    }
}
