//
//  ThreeTableRow.swift
//  TMDB
//
//  Created by jc.kim on 2/24/23.
//

import SwiftUI

struct ThreeTableRow: View {
    var movie: Movie
    @ObservedObject var imageLoader: ImageLoader
    
    init(movie: Movie) {
        self.movie = movie
        self.imageLoader = ImageLoader(service: ImageLoaderService(), path: movie.backdropPath ?? "")
    }
    
    var body: some View {
        HStack {
            Image(uiImage: imageLoader.image ?? UIImage())
                .resizable()
                .background(.gray)
                .aspectRatio(contentMode: .fill)
                .cornerRadius(5)
                .frame(width: 80, height: 80, alignment: .leading)
                .clipped()
            VStack(alignment: .leading) {
                Text(movie.title)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .lineLimit(1)
                Text(movie.overview)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
            }
            Spacer()
            Button { } label: { Image(systemName: "icloud.and.arrow.down") }
                .foregroundColor(.blue)
        }
        .frame(width: 370, alignment: .leading)
    }
}
