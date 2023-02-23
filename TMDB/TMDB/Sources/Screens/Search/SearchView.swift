//
//  SearchView.swift
//  TMDB
//
//  Created by jc.kim on 2/22/23.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject var viewModel: SearchViewModel
    
    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            VStack {
                search()
                content()
            }
            .navigationBarTitle("검색")
        }
        .alert(isPresented: $viewModel.showingAlert) {
            Alert(title: Text("Error"),
                  message: Text(viewModel.errorMessage))
        }
        .onTapGesture {
            UIApplication.shared.sendAction(
                #selector(UIResponder.resignFirstResponder),
                to:nil, from:nil, for:nil
            )
        }
    }
}

private extension SearchView {
    func search() -> some View {
        SearchBar(text: $viewModel.text)
            .padding([.leading, .trailing], 10)
    }
    
    func content() -> some View {
        List(viewModel.movies, id: \.id) { movie in
            SearchRow(movie: movie).onAppear {
                if let lastId = viewModel.movies.last?.id, lastId == movie.id {
                    viewModel.didScrollFetch()
                }
            }
        }.listStyle(.plain)
    }
    
    func details(for movie: Movie) -> some View {
        MovieResultView(movie: movie)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        let searchViewModel = SearchViewModel(service: MoviesService())
        return SearchView(viewModel: searchViewModel)
    }
}
