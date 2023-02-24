//
//  TrendViewModel.swift
//  TMDB
//
//  Created by jc.kim on 2/22/23.
//

import Combine
import SwiftUI

class TrendViewModel: ObservableObject {
    @Published var movies: [Movie]? = nil
    
    private let service: MoviesServiceType
    private var cancellables = Set<AnyCancellable>()
    
    init(
        service: MoviesServiceType,
        scheduler: DispatchQueue = DispatchQueue(label: "SearchViewModel")
    ) {
        self.service = service
    }
    
    func trending() {
        service.trending()
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
