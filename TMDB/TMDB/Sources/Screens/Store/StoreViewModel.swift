//
//  StoreViewModel.swift
//  TMDB
//
//  Created by jc.kim on 2/24/23.
//

import Foundation
import Combine
import SwiftUI

class StoreViewModel: ObservableObject {
    @Published var popularMovies: [Movie] = []
    @Published var topRatedMovies: [Movie] = []
    @Published var upcomingMovies: [Movie] = []
    @Published var genres: [Genre] = []
    
    private let service: MoviesServiceType
    private var cancellables = Set<AnyCancellable>()
    
    init(
        service: MoviesServiceType,
        scheduler: DispatchQueue = DispatchQueue(label: "SearchViewModel")
    ) {
        self.service = service
    }
    
    func popular() {
        service.popular()
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] value in
                    guard let self = self else {
                        return
                    }
                    switch value {
                    case .failure:
                        self.popularMovies = []
                    case .finished:
                        break
                    }
                },
                receiveValue: { [weak self] movies in
                    guard let self = self else {
                        return
                    }
                    self.popularMovies = movies.items
                }
            )
            .store(in: &cancellables)
    }
    
    func topRated() {
        service.topRated()
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] value in
                    guard let self = self else {
                        return
                    }
                    switch value {
                    case .failure:
                        self.topRatedMovies = []
                    case .finished:
                        break
                    }
                },
                receiveValue: { [weak self] movies in
                    guard let self = self else {
                        return
                    }
                    self.topRatedMovies = movies.items
                }
            )
            .store(in: &cancellables)
    }
    
    func upcoming() {
        service.upcoming()
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] value in
                    guard let self = self else {
                        return
                    }
                    switch value {
                    case .failure:
                        self.upcomingMovies = []
                    case .finished:
                        break
                    }
                },
                receiveValue: { [weak self] movies in
                    guard let self = self else {
                        return
                    }
                    self.upcomingMovies = movies.items
                }
            )
            .store(in: &cancellables)
    }
    
    func genre() {
        service.genre()
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] value in
                    guard let self = self else {
                        return
                    }
                    switch value {
                    case .failure:
                        self.genres = []
                    case .finished:
                        break
                    }
                },
                receiveValue: { [weak self] genres in
                    guard let self = self else {
                        return
                    }
                    self.genres = genres.items
                }
            )
            .store(in: &cancellables)
    }
}
