//
//  SmallTableRow.swift
//  TMDB
//
//  Created by jc.kim on 2/24/23.
//

import SwiftUI

struct SmallTableRow: View {
    var genre: Genre
    private let emojis = [
        "🤣", "🥃", "😎", "⌚️", "💯", "✅", "😀", "😂","🏈", "🚴‍♀️", "🎤", "🏔", "⛺️", "🏖", "🖥", "⌚️", "📱", "❤️", "☮️", "🦊", "🐝", "🐢", "🥃", "🍎", "🍑"
    ]
    
    init(genre: Genre) {
        self.genre = genre
    }
    
    var body: some View {
        HStack {
            Text(genre.name)
                .font(.title3)
                .foregroundColor(.secondary)
            Text(emojis.randomElement() ?? "")
        }
    }
}

struct SmallTableRow_Previews: PreviewProvider {
    static var previews: some View {
        let genre = Genre(id: 1, name: "아아5아")
        SmallTableRow(genre: genre)
    }
}
