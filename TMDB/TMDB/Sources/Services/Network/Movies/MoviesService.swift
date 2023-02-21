//
//  MoviesService.swift
//  TMDB
//
//  Created by jc.kim on 2/19/23.
//

import Foundation

final class MoviesService: HTTPClient, MoviesServiceType {
    func popular() async -> Result<Movies, NetworkError> {
        return await sendRequest(endpoint: MoviesEndpoint.popular, responseModel: Movies.self)
    }
    
    func topRated() async -> Result<Movies, NetworkError> {
        return await sendRequest(endpoint: MoviesEndpoint.topRated, responseModel: Movies.self)
    }
    
    func upcoming() async -> Result<Movies, NetworkError> {
        return await sendRequest(endpoint: MoviesEndpoint.upcomming, responseModel: Movies.self)
    }
    
    func genre() async -> Result<Genres, NetworkError> {
        return await sendRequest(endpoint: MoviesEndpoint.genre, responseModel: Genres.self)
    }

    func search(query: String, page: Int) async -> Result<Movies, NetworkError> {
        return await sendRequest(endpoint: MoviesEndpoint.search(query: query, page: page), responseModel: Movies.self)
    }
    
    func detail(id: Int) async -> Result<MovieDetail, NetworkError> {
        return await sendRequest(endpoint: MoviesEndpoint.movieDetail(id: id), responseModel: MovieDetail.self)
    }
    
    func trending() async -> Result<Movies, NetworkError> {
        return await sendRequest(endpoint: MoviesEndpoint.trending, responseModel: Movies.self)
    }
}
