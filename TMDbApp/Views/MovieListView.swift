//
//  MovieListView.swift
//  TMDbApp
//
//  Created by Charan Ganesh on 31/10/24.
//

import SwiftUI

struct MovieListView: View {
    @Environment(MovieListViewModel.self) var viewModel: MovieListViewModel
    @Namespace private var namespace
    
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        NavigationStack {
            ScrollView {
                /*
                LazyVStack {
                    WrappingHStack(alignment: .leading, fitContentWidth: true) {
                        ForEach(viewModel.movies, id: \.id) { movie in
                            NavigationLink(value: movie) {
                                MovieItemView(movie: movie)
                                    .onAppear {
                                        Task {
                                            await viewModel.loadNextPageIfNeeded(currentMovie: movie)
                                        }
                                    }
                            }
                            .matchedTransitionSource(id: movie.id, in: namespace)
                        }
                    }
                }
                 */
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(viewModel.movies, id: \.id) { movie in
                        if #available (iOS 18.0, *) {
                            NavigationLink(value: movie) {
                                MovieItemView(movie: movie)
                                    .onAppear {
                                        Task {
                                            await viewModel.loadNextPageIfNeeded(currentMovie: movie)
                                        }
                                    }
                            }
                            .matchedTransitionSource(id: movie.id, in: namespace)
                        } else {
                            NavigationLink(value: movie) {
                                MovieItemView(movie: movie)
                                    .onAppear {
                                        Task {
                                            await viewModel.loadNextPageIfNeeded(currentMovie: movie)
                                        }
                                    }
                            }
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Popular Movies")
            .scrollIndicators(.hidden)
            .navigationDestination(for: Movie.self) { movie in
                if #available(iOS 18.0, *) {
                    MovieDetailView(movie: movie)
                        .navigationTransition(.zoom(sourceID: movie.id, in: namespace))
                } else {
                    MovieDetailView(movie: movie)
                }
            }
        }
    }
}



#Preview {
    MovieListView()
}
