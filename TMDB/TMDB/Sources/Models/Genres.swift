//
//  Genres.swift
//  TMDB
//
//  Created by jc.kim on 2/19/23.
//

import Foundation

struct Genres {
    let items: [Genre]
}

extension Genres: Decodable {
    enum CodingKeys: String, CodingKey {
        case items = "genres"
    }
}
