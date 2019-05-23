//
//  DateFormat.swift
//  Books
//
//  Created by Spencer Prescott on 5/22/19.
//  Copyright © 2019 Spencer Prescott. All rights reserved.
//

import Foundation

final class DateFormat {
    static let shared = DateFormat()
    private let formatter = DateFormatter()
    
    func monthDateYear(from date: Date) -> String {
        formatter.dateFormat = "MMM d, yyyy"
        return formatter.string(from: date)
    }
}
