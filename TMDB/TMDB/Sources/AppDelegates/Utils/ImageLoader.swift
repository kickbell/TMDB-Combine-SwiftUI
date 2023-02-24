//
//  ImageLoader.swift
//  TMDB
//
//  Created by jc.kim on 2/24/23.
//

import UIKit
import Combine

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
