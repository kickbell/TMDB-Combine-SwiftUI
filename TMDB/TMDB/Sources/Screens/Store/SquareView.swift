//
//  SquareView.swift
//  TMDB
//
//  Created by jc.kim on 2/24/23.
//

import SwiftUI

struct SquareView: View {
    var items: [Movie]
    
    init(items: [Movie]) {
        self.items = items
    }
    
    private let rows = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: rows, spacing: 20) {
                ForEach(items, id: \.id) { movie in
                    SquareRow(movie: movie)
                }
            }
        }
        .frame(height: 400)
    }
}


struct SquareView_Previews: PreviewProvider {
    static var previews: some View {
        let movies = [
            Movie(backdropPath: nil, posterPath: nil, id: 1, overview: "overview", releaseDate: "releaseDate", title: "title", voteAverage: 0.0, voteCount: 1),
            Movie(backdropPath: nil, posterPath: nil, id: 2, overview: "overview", releaseDate: "releaseDate", title: "title", voteAverage: 0.0, voteCount: 1),
            Movie(backdropPath: nil, posterPath: nil, id: 3, overview: "overview", releaseDate: "releaseDate", title: "title", voteAverage: 0.0, voteCount: 1),
            Movie(backdropPath: nil, posterPath: nil, id: 4, overview: "overview", releaseDate: "releaseDate", title: "title", voteAverage: 0.0, voteCount: 1),
            Movie(backdropPath: nil, posterPath: nil, id: 5, overview: "overview", releaseDate: "releaseDate", title: "title", voteAverage: 0.0, voteCount: 1),
            Movie(backdropPath: nil, posterPath: nil, id: 6, overview: "overview", releaseDate: "releaseDate", title: "title", voteAverage: 0.0, voteCount: 1),
            Movie(backdropPath: nil, posterPath: nil, id: 7, overview: "overview", releaseDate: "releaseDate", title: "title", voteAverage: 0.0, voteCount: 1),
            Movie(backdropPath: nil, posterPath: nil, id: 8, overview: "overview", releaseDate: "releaseDate", title: "title", voteAverage: 0.0, voteCount: 1),
            Movie(backdropPath: nil, posterPath: nil, id: 9, overview: "overview", releaseDate: "releaseDate", title: "title", voteAverage: 0.0, voteCount: 1),
            Movie(backdropPath: nil, posterPath: nil, id: 10, overview: "overview", releaseDate: "releaseDate", title: "title", voteAverage: 0.0, voteCount: 1),
        ]
        SquareView(items: movies)
    }
}
