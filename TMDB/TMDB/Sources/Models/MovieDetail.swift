//
//  MovieDetail.swift
//  TMDB
//
//  Created by jc.kim on 2/18/23.
//

import Foundation



struct MovieDetail {
    let backdropPath: String?
    let genres: [Genre]
    let overview: String
    let posterPath: String?
    let releaseDate: String
    let title: String
    let voteAverage: Double
    let runtime: Int?
    let tagline: String?
}

extension MovieDetail: Decodable {
    enum CodingKeys: String, CodingKey {
        case overview
        case title
        case backdropPath = "backdrop_path"
        case genres
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case runtime
        case tagline
    }
}
