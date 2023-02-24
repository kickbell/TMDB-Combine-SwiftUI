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
    @ObservedObject var viewModel: StoreViewModel
    
    init(viewModel: StoreViewModel) {
        self.viewModel = viewModel
    }
    
    @State var featuredPage = 0
    @State var threeTablePage = 0
    
    let movie = Movie(backdropPath: nil, posterPath: nil, id: 9, overview: "overview", releaseDate: "releaseDate", title: "title", voteAverage: 0.0, voteCount: 1)
    
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    featured().onAppear { self.viewModel.popular() }
                    topandnew().onAppear { self.viewModel.topRated() }
                    upcoming().onAppear { self.viewModel.upcoming() }
                    category().onAppear { self.viewModel.genre() }
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
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10){
                    ForEach(viewModel.popularMovies, id: \.id) { movie in
                        FeaturedView(movie: movie)
                            .frame(width: UIScreen.main.bounds.width * 0.90)
                    }
                }
            }
        }
        .padding([.leading])
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
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ThreeTableView(items: viewModel.topRatedMovies)
                }
            }
        }
        .padding([.leading])
    }
    
    func upcoming() -> some View {
        VStack(alignment: .leading) {
            Divider()
            Text("UPCOMING")
                .font(Font.system(size: 22, weight: .bold))
                .foregroundColor(.primary)
            SquareView(items: viewModel.upcomingMovies)
        }.padding([.leading])
    }
    
    func category() -> some View {
        VStack(alignment: .leading, spacing: 20) {
            Divider()
            Text("영화 카테고리")
                .font(Font.system(size: 22, weight: .bold))
                .foregroundColor(.primary)
            ForEach(viewModel.genres, id: \.id) { genre in
                SmallTableRow(genre: genre)
            }
        }
        .padding([.leading, .trailing])
    }
    
}

struct StoreView_Previews: PreviewProvider {
    static var previews: some View {
        StoreView(viewModel: StoreViewModel(service: MoviesService()))
    }
}

