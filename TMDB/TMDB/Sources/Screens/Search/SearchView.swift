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
        .navigationViewStyle(.stack)
        .alert(isPresented: $viewModel.showingAlert) {
            Alert(title: Text("Error"), message: Text(viewModel.errorMessage))
        }
        .onTapGesture { resignFirstResponder() }
    }
}

private extension SearchView {
    func search() -> some View {
        SearchBar(text: $viewModel.text)
            .padding([.leading, .trailing], 10)
    }
    
    func content() -> some View {
        List(viewModel.movies, id: \.id) { movie in
            ZStack(alignment: .leading) {
                NavigationLink(destination: MovieResultView(movie: movie)) {
                    EmptyView()
                }
                .opacity(0.0)
                
                SearchRow(movie: movie).onAppear {
                    if let lastId = viewModel.movies.last?.id,
                       lastId == movie.id {
                        viewModel.didScrollFetch()
                    }
                }
            }
        }.listStyle(.plain)
    }
    
    func resignFirstResponder() {
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to:nil, from:nil, for:nil
        )
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        let searchViewModel = SearchViewModel(service: MoviesService())
        return SearchView(viewModel: searchViewModel)
    }
}
