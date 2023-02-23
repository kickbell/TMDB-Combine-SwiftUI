//
//  SearchRow.swift
//  TMDB
//
//  Created by jc.kim on 2/23/23.
//

import SwiftUI
import Combine

struct SearchRow: View {
    var movie: Movie
    @ObservedObject var imageLoader: ImageLoader
    
    init(movie: Movie) {
        self.movie = movie
        self.imageLoader = ImageLoader(service: ImageLoaderService(), path: movie.backdropPath ?? "")
    }
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                Image(uiImage: imageLoader.image ?? UIImage())
                    .resizable()
                    .aspectRatio(1.0/1.0, contentMode: .fill)
                    .cornerRadius(5)
                    .frame(width: 62, height: 62)
                    
                VStack(alignment: .leading) {
                    Text(movie.releaseDate)
                        .font(Font.system(size: 12, weight: .bold))
                        .foregroundColor(.blue)
                    Text(movie.title)
                        .font(.title2)
                        .foregroundColor(.primary)
                        .lineLimit(1)
                    Text(movie.overview)
                        .font(.body)
                        .foregroundColor(.secondary)
                        .lineLimit(3)
                }
            }
        }
    }
}

extension String {
    
    
    
    func useNonBreakingSpace() -> String {
        
        return self.replacingOccurrences(of: " ", with: "\u{202F}\u{202F}")
    }
    

    
}

struct SearchRow_Previews: PreviewProvider {
    static var previews: some View {
        let movie = Movie(backdropPath: nil, posterPath: nil, id: 1, overview: "overview", releaseDate: "releaseDate", title: "title", voteAverage: 0.0, voteCount: 1)
        SearchRow(movie: movie)
            .previewLayout(.fixed(width: 450, height: 150))
    }
}
