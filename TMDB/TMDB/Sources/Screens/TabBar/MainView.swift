//
//  MainView.swift
//  TMDB
//
//  Created by jc.kim on 2/22/23.
//

import SwiftUI
import Combine

struct MainView: View {
    @ObservedObject var storeViewModel: StoreViewModel
    @ObservedObject var searchViewModel: SearchViewModel
    @ObservedObject var trendViewModel: TrendViewModel
    
    init(
        storeViewModel: StoreViewModel,
        searchViewModel: SearchViewModel,
        trendViewModel: TrendViewModel
    ) {
        self.storeViewModel = storeViewModel
        self.searchViewModel = searchViewModel
        self.trendViewModel = trendViewModel
    }
    
    var body: some View {
        TabView {
            StoreView(viewModel: storeViewModel)
                .tabItem {
                    Image(systemName: "cart.fill")
                    Text("스토어")
                }
            
            SearchView(viewModel: searchViewModel)
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("검색")
                }
            
            TrendView(viewModel: trendViewModel)
                .tabItem {
                    Image(systemName: "t.circle.fill")
                    Text("트렌드")
                }
        }
        .accentColor(.black)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        let moviesService = MoviesService()
        let storeViewModel = StoreViewModel(service: moviesService)
        let searchViewModel = SearchViewModel(service: moviesService)
        let trendViewModel = TrendViewModel(service: moviesService)
        
        return MainView(storeViewModel: storeViewModel,
                        searchViewModel: searchViewModel,
                        trendViewModel: trendViewModel)
    }
}

