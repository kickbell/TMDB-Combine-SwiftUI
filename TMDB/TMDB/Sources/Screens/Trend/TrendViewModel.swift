//
//  TrendViewModel.swift
//  TMDB
//
//  Created by jc.kim on 2/22/23.
//

import Combine
import SwiftUI

final class ImageLoader: ObservableObject {
    
    @Published var image: UIImage? = nil
    
    private var service: ImageLoaderServiceType
    private var cancellable: AnyCancellable?
    
    init(service: ImageLoaderServiceType, path: String) {
        self.service = service
        
        let url = URL(string: ApiConstants.mediumImageUrl + path)!
        cancellable = service.loadImage(from: url)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { [weak self] image in
                    self?.image = image
                }
            )
    }
}

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
