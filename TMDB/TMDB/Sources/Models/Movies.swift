//
//  Movies.swift
//  TMDB
//
//  Created by jc.kim on 2/18/23.
//

import Foundation

struct Movies {
    let items: [Movie]
    let count: Int
}

extension Movies: Decodable {
    enum CodingKeys: String, CodingKey {
        case items = "results"
        case count = "total_results"
    }
}
