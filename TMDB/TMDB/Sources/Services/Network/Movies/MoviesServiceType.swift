//
//  MoviesServiceType.swift
//  TMDB
//
//  Created by jc.kim on 2/19/23.
//

import Foundation

protocol MoviesServiceType: AnyObject {
    func popular() async -> Result<Movies, NetworkError>
    func topRated() async -> Result<Movies, NetworkError>
    func upcoming() async -> Result<Movies, NetworkError>
    func genre() async -> Result<Genres, NetworkError>
    func search(query: String, page: Int) async -> Result<Movies, NetworkError>
    func detail(id: Int) async -> Result<MovieDetail, NetworkError>
    func trending() async -> Result<Movies, NetworkError>
}

enum NetworkError: Error, CustomStringConvertible {
    case decode
    case invalidURL
    case noResponse
    case unauthorized
    case unexpectedStatusCode
    case unknown
    
    var description: String {
        switch self {
        case .decode: return ""
        case .invalidURL: return ""
        case .noResponse: return ""
        case .unauthorized: return ""
        case .unexpectedStatusCode: return ""
        case .unknown: return ""
        }
    }
}
