//
//  ImageLoaderService.swift
//  TMDB
//
//  Created by jc.kim on 2/19/23.
//

import Foundation
import UIKit.UIImage

final class ImageLoaderService: ImageLoaderServiceType {
    static let shared = ImageLoaderService()
    
    private let cache: ImageCacheType
    private lazy var backgroundQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 5
        return queue
    }()

    public init(cache: ImageCacheType = ImageCache()) {
        self.cache = cache
    }

    public func loadImage(from url: URL, completion: @escaping (Result<UIImage?, Never>) -> Void) {
        if let image = cache[url] {
            completion(.success(image))
        }
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print(error.localizedDescription)
            }
            if let data = data {
                let image = UIImage(data: data)
                self.cache[url] = image
                completion(.success(image))
            }
        }.resume()
    }
}
