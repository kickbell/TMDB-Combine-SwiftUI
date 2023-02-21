//
//  Genre.swift
//  TMDB
//
//  Created by jc.kim on 2/18/23.
//

import Foundation

struct Genre: Decodable {
    let id: Int
    let name: String
}

extension Genre: Hashable {
    public static func == (lhs: Genre, rhs: Genre) -> Bool {
        return lhs.id == rhs.id
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
