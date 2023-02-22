//
//  MoviesService.swift
//  TMDB
//
//  Created by jc.kim on 2/19/23.
//

import Foundation
import Combine

final class MoviesService: HTTPClient, MoviesServiceType {
    func popular() -> AnyPublisher<Movies, NetworkError> {
        return sendRequest(endpoint: MoviesEndpoint.popular, responseModel: Movies.self)
    }
    
    func topRated() -> AnyPublisher<Movies, NetworkError> {
        return sendRequest(endpoint: MoviesEndpoint.topRated, responseModel: Movies.self)
    }
    
    func upcoming() -> AnyPublisher<Movies, NetworkError> {
        return sendRequest(endpoint: MoviesEndpoint.upcomming, responseModel: Movies.self)
    }
    
    func genre() -> AnyPublisher<Genres, NetworkError> {
        return sendRequest(endpoint: MoviesEndpoint.genre, responseModel: Genres.self)
    }

    func search(query: String, page: Int) -> AnyPublisher<Movies, NetworkError> {
        return sendRequest(endpoint: MoviesEndpoint.search(query: query, page: page), responseModel: Movies.self)
    }
    
    func detail(id: Int) -> AnyPublisher<MovieDetail, NetworkError> {
        return sendRequest(endpoint: MoviesEndpoint.movieDetail(id: id), responseModel: MovieDetail.self)
    }
    
    func trending() -> AnyPublisher<Movies, NetworkError> {
        return sendRequest(endpoint: MoviesEndpoint.trending, responseModel: Movies.self)
    }
}
