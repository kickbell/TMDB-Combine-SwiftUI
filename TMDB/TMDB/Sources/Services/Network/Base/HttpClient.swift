//
//  HttpClient.swift
//  TMDB
//
//  Created by jc.kim on 2/19/23.
//

import Foundation
import Combine

protocol HTTPClient {
    func sendRequest<T: Decodable>(endpoint: Endpoint, responseModel: T.Type) -> AnyPublisher<T, NetworkError>
}

extension HTTPClient {
    func sendRequest<T: Decodable>(
        endpoint: Endpoint,
        responseModel: T.Type
    ) -> AnyPublisher<T, NetworkError> {
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path
        urlComponents.queryItems = endpoint.queryItems
        
        guard let url = urlComponents.url else {
            return Fail(error: .invalidURL).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.header

        if let body = endpoint.body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        }
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { (data, response) -> T in
                guard let response = response as? HTTPURLResponse else {
                    throw NetworkError.noResponse
                }
                switch response.statusCode {
                case 200...299:
                    return try JSONDecoder().decode(responseModel, from: data)
                case 401:
                    throw NetworkError.unauthorized
                default:
                    throw NetworkError.unexpectedStatusCode
                }
            }
            .mapError { _ in NetworkError.unknown }
            .eraseToAnyPublisher()
    }
}
