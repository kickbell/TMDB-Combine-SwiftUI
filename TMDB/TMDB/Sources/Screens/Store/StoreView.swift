//
//  StoreView.swift
//  TMDB
//
//  Created by jc.kim on 2/24/23.
//

import SwiftUI
import Combine
import Pages

struct StoreView: View {
    @ObservedObject var viewModel: SearchViewModel
    
    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
    }
    
    
    let movie = Movie(backdropPath: nil, posterPath: nil, id: 1, overview: "overview", releaseDate: "releaseDate", title: "title", voteAverage: 0.0, voteCount: 1)
    
    let movies = [
        Movie(backdropPath: nil, posterPath: nil, id: 1, overview: "overview", releaseDate: "releaseDate", title: "tit32le", voteAverage: 0.0, voteCount: 1),
        Movie(backdropPath: nil, posterPath: nil, id: 2, overview: "overview", releaseDate: "releaseDate", title: "tit33le", voteAverage: 0.0, voteCount: 1),
        Movie(backdropPath: nil, posterPath: nil, id: 3, overview: "overview", releaseDate: "releaseDate", title: "title", voteAverage: 0.0, voteCount: 1),
        Movie(backdropPath: nil, posterPath: nil, id: 4, overview: "overview", releaseDate: "releaseDate", title: "title", voteAverage: 0.0, voteCount: 1),
        Movie(backdropPath: nil, posterPath: nil, id: 5, overview: "overview", releaseDate: "releaseDate", title: "title", voteAverage: 0.0, voteCount: 1),
        Movie(backdropPath: nil, posterPath: nil, id: 6, overview: "overview", releaseDate: "releaseDate", title: "tit323le", voteAverage: 0.0, voteCount: 1),
        Movie(backdropPath: nil, posterPath: nil, id: 7, overview: "overview", releaseDate: "releaseDate", title: "tit44le", voteAverage: 0.0, voteCount: 1),
        Movie(backdropPath: nil, posterPath: nil, id: 8, overview: "overview", releaseDate: "releaseDate", title: "ti44tle", voteAverage: 0.0, voteCount: 1),
        Movie(backdropPath: nil, posterPath: nil, id: 9, overview: "overview", releaseDate: "releaseDate", title: "t33itle", voteAverage: 0.0, voteCount: 1),
        Movie(backdropPath: nil, posterPath: nil, id: 10, overview: "overview", releaseDate: "releaseDate", title: "ti33tle", voteAverage: 0.0, voteCount: 1),
    ]
    
    let genres = [
        Genre(id: 1, name: "아아5아"),
        Genre(id: 2, name: "아아5아"),
        Genre(id: 3, name: "아아5아"),
        Genre(id: 4, name: "아아아5"),
        Genre(id: 5, name: "아아아123"),
        Genre(id: 6, name: "아아아123"),
        
    ]
    
    @State var featuredPage = 0
    @State var threeTablePage = 0
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    featured()
                    topandnew()
                    upcoming()
                    category()
                }
            }
            .navigationBarTitle("스토어")
        }
        .navigationViewStyle(.stack)
    }
}

private extension StoreView {
    func featured() -> some View {
        VStack(alignment: .leading) {
            Divider()
            Pages(currentPage: $featuredPage, hasControl: false) {
                FeaturedView(movie: movie)
                FeaturedView(movie: movie)
                FeaturedView(movie: movie)
                FeaturedView(movie: movie)
            }
            .frame(height: 300, alignment: .center)
        }
    }
    
    func topandnew() -> some View {
        VStack(alignment: .leading) {
            Divider()
            Text("HOT & NEW")
                .font(Font.system(size: 22, weight: .bold))
                .foregroundColor(.primary)
            Text("최고 등급의 평점을 받은 영화입니다.")
                .font(.headline)
                .foregroundColor(.secondary)
            Pages(currentPage: $threeTablePage, hasControl: false) {
                ThreeTableView(items: movies)
                ThreeTableView(items: movies)
                ThreeTableView(items: movies)
                ThreeTableView(items: movies)
                ThreeTableView(items: movies)
            }
            .frame(height: 280, alignment: .center)
        }
        .padding([.leading, .trailing])
    }
    
    func upcoming() -> some View {
        VStack(alignment: .leading) {
            Divider()
            Text("UPCOMING")
                .font(Font.system(size: 22, weight: .bold))
                .foregroundColor(.primary)
            SquareView(items: movies)
        }.padding([.leading, .trailing])
    }
    
    func category() -> some View {
        VStack(alignment: .leading, spacing: 20) {
            Divider()
            Text("영화 카테고리")
                .font(Font.system(size: 22, weight: .bold))
                .foregroundColor(.primary)
            ForEach(genres, id: \.id) { genre in
                SmallTableRow(genre: genre)
            }
        }
        .padding([.leading, .trailing])
    }
    
}

struct StoreView_Previews: PreviewProvider {
    static var previews: some View {
        StoreView(viewModel: SearchViewModel(service: MoviesService()))
    }
}
    
