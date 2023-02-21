//
//  MoviesEndpoint.swift
//  TMDB
//
//  Created by jc.kim on 2/19/23.
//

import Foundation

enum MoviesEndpoint {
    case popular
    case topRated
    case upcomming
    case genre
    case search(query: String, page: Int)
    case movieDetail(id: Int)
    case trending
}

extension MoviesEndpoint: Endpoint {
    var path: String {
        switch self {
        case .popular:
            return "/3/movie/popular"
        case .topRated:
            return "/3/movie/top_rated"
        case .upcomming:
            return "/3/movie/upcoming"
        case .genre:
            return "/3/genre/movie/list"
        case .search:
            return "/3/search/movie"
        case .movieDetail(let id):
            return "/3/movie/\(id)"
        case .trending:
            return "/3/trending/movie/day"
        }
    }

    var method: HttpMethod {
        switch self {
        default:
            return .get
        }
    }

    var header: [String: String]? {
        return nil
    }
    
    var body: [String: String]? {
        return nil
    }
    
    var queryItems: [URLQueryItem] {
        var queryItems:[URLQueryItem] = [
            URLQueryItem(name: "api_key", value: ApiConstants.apiKey),
            URLQueryItem(name: "language", value: "ko-KR"),
        ]
        
        switch self {
        case .search(query: let query, page: let page):
            queryItems.append(URLQueryItem(name: "query", value: query))
            queryItems.append(URLQueryItem(name: "page", value: "\(page)"))
        case .movieDetail(id: let id):
            queryItems.append(URLQueryItem(name: "movie_id", value: "\(id)"))
        default: break
        }
        
        return queryItems
    }
}
