//
//  FeaturedView.swift
//  TMDB
//
//  Created by jc.kim on 2/24/23.
//

import SwiftUI
import Combine

struct FeaturedView: View {
    var movie: Movie
    @ObservedObject var imageLoader: ImageLoader
    
    init(movie: Movie) {
        self.movie = movie
        self.imageLoader = ImageLoader(service: ImageLoaderService(), path: movie.backdropPath ?? "")
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(movie.releaseDate)
                .font(Font.system(size: 12, weight: .bold))
                .foregroundColor(.blue)
            Text(movie.title)
                .font(.title2)
                .foregroundColor(.primary)
                .lineLimit(1)
            Text("구매: \(movie.voteCount), 평점: \(movie.voteAverage)")
                .font(.body)
                .foregroundColor(.secondary)
                .lineLimit(1)
            Image(uiImage: imageLoader.image ?? UIImage())
                .resizable()
                .aspectRatio(16.0/9.0, contentMode: .fit)
                .background(.gray)
                .cornerRadius(5)
                .clipped()
        }
    }
}

struct FeaturedView_Previews: PreviewProvider {
    static var previews: some View {
        let movie = Movie(backdropPath: nil, posterPath: nil, id: 1, overview: "overview", releaseDate: "releaseDate", title: "title", voteAverage: 0.0, voteCount: 1)
        FeaturedView(movie: movie)
    }
}
