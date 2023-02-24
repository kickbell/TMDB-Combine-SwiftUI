//
//  SceneDelegate.swift
//  TMDB
//
//  Created by jc.kim on 2/18/23.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let moviesService = MoviesService()
        
        let storeViewModel = StoreViewModel(service: moviesService)
        let searchViewModel = SearchViewModel(service: moviesService)
        let trendViewModel = TrendViewModel(service: moviesService)
        
        let mainView = MainView(storeViewModel: storeViewModel,
                                searchViewModel: searchViewModel,
                                trendViewModel: trendViewModel)
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = UIHostingController(rootView: mainView)
        window?.makeKeyAndVisible()
    }

}

