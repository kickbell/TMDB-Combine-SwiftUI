//
//  Item.swift
//  TMDB
//
//  Created by jc.kim on 2/19/23.
//

import Foundation

struct Item: Hashable {
    let topRated: Movie?
    let popular: Movie?
    let genre: Genre?
    let upcoming: Movie?
    
    init(topRated: Movie? = nil, popular: Movie? = nil, genre: Genre? = nil, upcoming: Movie? = nil) {
        self.topRated = topRated
        self.popular = popular
        self.genre = genre
        self.upcoming = upcoming
    }
    
    private let identifier = UUID()
}
