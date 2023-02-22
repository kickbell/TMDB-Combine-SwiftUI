//
//  MoviesServiceType.swift
//  TMDB
//
//  Created by jc.kim on 2/19/23.
//

import Foundation
import Combine

protocol MoviesServiceType: AnyObject {
    func popular() -> AnyPublisher<Movies, NetworkError>
    func topRated() -> AnyPublisher<Movies, NetworkError>
    func upcoming() -> AnyPublisher<Movies, NetworkError>
    func genre() -> AnyPublisher<Genres, NetworkError>
    func search(query: String, page: Int) -> AnyPublisher<Movies, NetworkError>
    func detail(id: Int) -> AnyPublisher<MovieDetail, NetworkError>
    func trending() -> AnyPublisher<Movies, NetworkError>
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
