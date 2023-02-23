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
        case .decode: return "디코딩 중에 오류가 발생했습니다."
        case .invalidURL: return "유효하지 않은 URL입니다."
        case .noResponse: return "응답이 없습니다."
        case .unauthorized: return "접근 권한이 없습니다."
        case .unexpectedStatusCode: return "예상하지 못한 상태코드입니다."
        case .unknown: return "알 수 없는 오류입니다."
        }
    }
}
