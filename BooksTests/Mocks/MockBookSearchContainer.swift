//
//  MockBookSearchContainer.swift
//  BooksTests
//
//  Created by Spencer Prescott on 5/21/19.
//  Copyright © 2019 Spencer Prescott. All rights reserved.
//

import Foundation
@testable import Books

extension BookSearchContainer {
    static var mockData: Data {
        let json: [String: Any] = [
            "start": 0,
            "num_found": 1,
            "docs": [
                [
                    "cover_i": 258027,
                    "has_fulltext": true,
                    "edition_count": 120,
                    "title": "The Lord of the Rings",
                    "author_name": [
                        "J. R. R. Tolkien"
                    ],
                    "first_publish_year": 1954,
                    "key": "OL27448W",
                    "ia": [
                        "returnofking00tolk_1",
                        "lordofrings00tolk_1",
                        "lordofrings00tolk_0",
                        "lordofrings00tolk_3",
                        "lordofrings00tolk_2",
                        "lordofrings00tolk",
                        "twotowersbeingse1970tolk",
                        "lordofring00tolk",
                        "lordofrings56tolk",
                        "lordofringstolk00tolk",
                        "fellowshipofring00tolk_0"
                    ],
                    "author_key": [
                        "OL26320A"
                    ],
                    "public_scan_b": true
                ]
            ]
        ]
        
        return try! JSONSerialization.data(withJSONObject: json, options: [])
    }
}
