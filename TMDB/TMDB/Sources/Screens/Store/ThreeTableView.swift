//
//  ThreeTableView.swift
//  TMDB
//
//  Created by jc.kim on 2/24/23.
//

import SwiftUI


struct ThreeTableView: View {
    var items: [Movie]
    
    init(items: [Movie]) {
        self.items = items
    }
    
    private let rows = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    private let examrows = [
        GridItem(.fixed(80)),
        GridItem(.fixed(80)),
        GridItem(.fixed(80))
    ]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: examrows, spacing: 20) {
                ForEach(items, id: \.id) { movie in
                    NavigationLink(destination: MovieResultView(movie: movie)) {
                        ThreeTableRow(movie: movie)
                    }
                }
            }
        }
    }
}

struct ThreeTableView_Previews: PreviewProvider {
    static var previews: some View {
        let movies = [
            Movie(backdropPath: nil, posterPath: nil, id: 1, overview: "overview", releaseDate: "releaseDate", title: "title", voteAverage: 0.0, voteCount: 1),
            Movie(backdropPath: nil, posterPath: nil, id: 2, overview: "overview", releaseDate: "releaseDate", title: "title", voteAverage: 0.0, voteCount: 1),
            Movie(backdropPath: nil, posterPath: nil, id: 3, overview: "overview", releaseDate: "releaseDate", title: "title", voteAverage: 0.0, voteCount: 1),
            Movie(backdropPath: nil, posterPath: nil, id: 4, overview: "overview", releaseDate: "releaseDate", title: "title", voteAverage: 0.0, voteCount: 1),
        ]
        ThreeTableView(items: movies)
    }
}
