//
//  SquareRow.swift
//  TMDB
//
//  Created by jc.kim on 2/24/23.
//

import SwiftUI

struct SquareRow: View {
    var movie: Movie
    @ObservedObject var imageLoader: ImageLoader
    
    init(movie: Movie) {
        self.movie = movie
        self.imageLoader = ImageLoader(service: ImageLoaderService(), path: movie.backdropPath ?? "")
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Image(uiImage: imageLoader.image ?? UIImage())
                .aspectRatio(contentMode: .fill)
                .frame(width: 170, height: 170)
                .background(.gray)
                .cornerRadius(5)
                .clipped()
            Text(movie.title)
                .font(.subheadline)
                .foregroundColor(.primary)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: 170, alignment: .leading)
                .lineLimit(1)
        }
    }
}

struct SquareRow_Previews: PreviewProvider {
    static var previews: some View {
        let movie = Movie(backdropPath: nil, posterPath: nil, id: 1, overview: "overview", releaseDate: "releaseDate", title: "title", voteAverage: 0.0, voteCount: 1)
        SquareRow(movie: movie)
    }
}
