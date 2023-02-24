//
//  ThreeTableView.swift
//  TMDB
//
//  Created by jc.kim on 2/24/23.
//

import SwiftUI

struct ThreeTableView: View {
    var items: [Movie]
    
    var body: some View {
        VStack {
            ScrollView(.horizontal) {
                ForEach(0..<3) { row in
                    HStack {
                        ForEach(0 ..< items.count/3) { column in
                            ThreeTableRow(movie: self.items[self.determineCurrentCell(row: row, column: column)])
                        }
                    }
                }
            }
        }
    }
    
    func determineCurrentCell(row: Int, column: Int) -> Int {
        return ((((column + 1) * 3) - row) - 1)
    }
}


struct ThreeTableView_Previews: PreviewProvider {
    static var previews: some View {
        let movies = [
            Movie(backdropPath: nil, posterPath: nil, id: 1, overview: "overview", releaseDate: "releaseDate", title: "title", voteAverage: 0.0, voteCount: 1),
            Movie(backdropPath: nil, posterPath: nil, id: 1, overview: "overview", releaseDate: "releaseDate", title: "title", voteAverage: 0.0, voteCount: 1),
            Movie(backdropPath: nil, posterPath: nil, id: 1, overview: "overview", releaseDate: "releaseDate", title: "title", voteAverage: 0.0, voteCount: 1),
            Movie(backdropPath: nil, posterPath: nil, id: 1, overview: "overview", releaseDate: "releaseDate", title: "title", voteAverage: 0.0, voteCount: 1),
        ]
        ThreeTableView(items: movies)
    }
}
