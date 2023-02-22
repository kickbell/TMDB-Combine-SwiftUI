//
//  SearchViewModel.swift
//  TMDB
//
//  Created by jc.kim on 2/22/23.
//

import Combine
import SwiftUI

class SearchViewModel: ObservableObject {
    @Published var movies: [Movie]? = nil
    @Published var query: String = ""
    
    private let service: MoviesServiceType
    private var cancellables = Set<AnyCancellable>()
    
    init(
        service: MoviesServiceType,
        scheduler: DispatchQueue = DispatchQueue(label: "SearchViewModel")
    ) {
        self.service = service
        _ = $query
            .dropFirst(1)
            .debounce(for: .seconds(0.5), scheduler: scheduler)
            .sink(receiveValue: search(query:))
    }
    
    func search(query: String) {
        service.search(query: query, page: 1)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] value in
                    guard let self = self else {
                        return
                    }
                    switch value {
                    case .failure:
                        self.movies = nil
                    case .finished:
                        break
                    }
                },
                receiveValue: { [weak self] movies in
                    guard let self = self else {
                        return
                    }
                    self.movies = movies.items
                }
            )
            .store(in: &cancellables)
    }
    
}
