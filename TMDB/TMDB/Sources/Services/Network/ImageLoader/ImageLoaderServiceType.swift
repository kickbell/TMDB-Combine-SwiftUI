//
//  ImageLoader.swift
//  TMDB
//
//  Created by jc.kim on 2/19/23.
//

import Foundation
import UIKit.UIImage

protocol ImageLoaderServiceType: AnyObject {
    func loadImage(from url: URL, completion: @escaping (Result<UIImage?, Never>) -> Void)
}
