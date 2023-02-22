//
//  TrendMovieView.swift
//  TMDB
//
//  Created by jc.kim on 2/22/23.
//

import SwiftUI

struct TrendView: View {
    @ObservedObject var viewModel: TrendViewModel
    
    init(viewModel: TrendViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 10) {
                subtitle()
                content().onAppear {
                    self.viewModel.trending()
                }
                move()
                Spacer()
            }
            .padding([.leading, .trailing], 5)
            .navigationBarTitle("트렌드", displayMode: .automatic)
            .navigationBarItems(trailing: Button(action: {
                self.viewModel.movies?.shuffle()
            }, label: {
                Image(systemName: "arrow.clockwise")
                    .tint(.blue)
            }))
            .padding()
        }
        
    }
}

private extension TrendView {
    func subtitle() -> some View {
        Text("최근 24시간 동안 트렌드 리스트의 영화를 랜덤으로 나타냅니다. 우측 버튼으로 새로고침 할 수 있습니다.")
            .font(.body)
            .foregroundColor(.secondary)
        
    }
    
    func content() -> some View {
        guard let movie = viewModel.movies?.first else {
            return AnyView(Text(""))
        }
        return AnyView(MovieResultView(movie: movie))
    }
    
    func move() -> some View {
        Button(action: {
            guard let movie = viewModel.movies?.first,
                  let url = URL(string: ApiConstants.originalImageUrl + (movie.posterPath ?? "")) else { return }
            UIApplication.shared.open(url)
        }) {
            Text("포스터 보러가기")
                .frame(maxWidth: .infinity, maxHeight: 50)
                .foregroundColor(.white)
                .background(Color.blue)
        }
    }
}



struct TrendMovieView_Previews: PreviewProvider {
    static var previews: some View {
        let trendViewModel = TrendViewModel(service: MoviesService())
        TrendView(viewModel: trendViewModel)
    }
}
