//
//  MainTabBarController.swift
//  TMDB
//
//  Created by jc.kim on 2/18/23.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addAttribues()
        addViewControllers()
    }
    
    // MARK: - Methods
    
    func addAttribues() {
        self.tabBar.tintColor = .label
        self.tabBar.barStyle = .default
    }
    
    func addViewControllers() {
        let movieStore = UINavigationController(rootViewController: MovieStoreController(service: MoviesService()))
        let movieStoreItem = UITabBarItem(title: "스토어", image: UIImage(systemName: "cart"), selectedImage: UIImage(systemName: "cart.fill"))
        movieStore.tabBarItem = movieStoreItem
        
        let searchMovie = UINavigationController(rootViewController: SearchMovieController(service: MoviesService()))
        let searchMovieItem = UITabBarItem(title: "검색", image: UIImage(systemName: "magnifyingglass"), selectedImage: nil)
        searchMovie.tabBarItem = searchMovieItem
        
        let trendMovie = UINavigationController(rootViewController: TrendMovieController(service: MoviesService()))
        let trendMovieItem = UITabBarItem(title: "트렌드", image: UIImage(systemName: "t.circle"), selectedImage: UIImage(systemName: "t.circle.fill"))
        trendMovie.tabBarItem = trendMovieItem
        
        self.viewControllers = [movieStore, searchMovie, trendMovie]
    }
}
