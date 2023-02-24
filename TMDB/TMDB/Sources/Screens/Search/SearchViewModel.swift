//
//  SearchViewModel.swift
//  TMDB
//
//  Created by jc.kim on 2/22/23.
//

import Combine
import SwiftUI

class SearchViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var totalCount: Int = 0
    @Published var text: String = ""
    
    @Published var showingAlert: Bool = false
    @Published var errorMessage: String = ""
    
    private var page: Int = 1
    private let service: MoviesServiceType
    private var cancellables = Set<AnyCancellable>()
    
    init(
        service: MoviesServiceType,
        scheduler: DispatchQueue = DispatchQueue(label: "SearchViewModel")
    ) {
        self.service = service
        
        $text
            .dropFirst(1)
            .handleEvents(receiveOutput: { [weak self] _ in
                guard let self = self else { return }
                self.movies = []
                self.page = 1
            })
            .debounce(for: .seconds(0.5), scheduler: scheduler)
            .sink(receiveValue: search(text:))
            .store(in: &cancellables)
    }
    
    func didScrollFetch() {
        guard movies.count < totalCount else { return }
        self.page += 1
        self.search(text: text)
    }
    
    private func search(text: String) {
        service.search(query: text, page: page)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { value in
                    switch value {
                    case .failure(let error):
                        self.movies = []
                        self.showingAlert = true
                        self.errorMessage = error.description
                    case .finished: break
                    }
                },
                receiveValue: { [weak self] movies in
                    guard let self = self else { return }
                    self.movies.append(contentsOf: movies.items)
                    self.totalCount = movies.count
                }
            )
            .store(in: &cancellables)
    }
}

