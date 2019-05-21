//
//  Result.swift
//  Books
//
//  Created by Spencer Prescott on 5/21/19.
//  Copyright © 2019 Spencer Prescott. All rights reserved.
//

import Foundation

/// Result type from basic structure of swift 5 built in Result
enum Result<SuccessType, ErrorType: Error> {
    case success(result: SuccessType)
    case failure(error: ErrorType)
}
