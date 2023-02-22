//
//  MovieResultView.swift
//  TMDB
//
//  Created by jc.kim on 2/22/23.
//

import SwiftUI
import Combine

struct MovieResultView: View {
    var movie: Movie
    @ObservedObject var imageLoader: ImageLoader

    init(movie: Movie) {
        self.movie = movie
        self.imageLoader = ImageLoader(service: ImageLoaderService(), path: movie.backdropPath ?? "")
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Image(uiImage: imageLoader.image ?? UIImage())
                .resizable()
                .aspectRatio(contentMode: .fit)
                .background(.gray)
                .padding([.bottom], 10)
            Text(movie.title)
                .font(.title3)
                .foregroundColor(.primary)
            Text("| ⭐️\(movie.voteAverage) | \(movie.releaseDate) |")
                .font(.subheadline)
                .foregroundColor(.primary)
            Text(movie.overview)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
}

struct MovieResultView_Previews: PreviewProvider {
    static var previews: some View {
        let movie = Movie(backdropPath: nil, posterPath: nil, id: 1, overview: "overview", releaseDate: "releaseDate", title: "title", voteAverage: 0.0, voteCount: 1)
        MovieResultView(movie: movie)
    }
}
