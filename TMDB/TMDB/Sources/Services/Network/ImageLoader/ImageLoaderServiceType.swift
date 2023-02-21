//
//  ImageLoader.swift
//  TMDB
//
//  Created by jc.kim on 2/19/23.
//

import Foundation
import UIKit.UIImage
import Combine

protocol ImageLoaderServiceType: AnyObject {
    func loadImage(from url: URL) -> AnyPublisher<UIImage?, Never>
}
