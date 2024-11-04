//
//  MovieListViewModel.swift
//  TMDbApp
//
//  Created by Charan Ganesh on 31/10/24.
//

import Foundation
import SwiftUI
import Combine
import Observation

@Observable
class MovieListViewModel {
    var movies: [Movie] = []
    var runtimes: [Int: Int] = [:]
    private let movieService: MovieServiceProtocol
    private var currentPage = 1
    private var totalPages = 1
    var isLoading = false
    
    init(movieService: MovieServiceProtocol = MovieService()) {
        self.movieService = movieService
    }
    
    func fetchMovies(page: Int = 1) async {
        guard !isLoading, page <= totalPages else { return }
        
        isLoading = true
        do {
            let movieModel = try await movieService.fetchPopularMovies(page: page)
            self.movies += movieModel.results
            self.currentPage = movieModel.page
            self.totalPages = movieModel.totalPages
            for movie in movieModel.results {
                await fetchMovieDetailsIfNeeded(for: movie)
            }
        } catch {
            print("Error fetching movies: \(error)")
        }
        isLoading = false
    }
    
    func loadNextPageIfNeeded(currentMovie: Movie) async {
        guard let index = movies.firstIndex(where: { $0.id == currentMovie.id }) else { return }
        
        if index >= movies.count - 5 {
            await fetchMovies(page: currentPage + 1)
        }
    }
    private func fetchMovieDetailsIfNeeded(for movie: Movie) async {
        guard runtimes[movie.id] == nil else { return } // skipping if runtime already fetched

        do {
            let details = try await movieService.fetchMovieDetails(movieID: movie.id)
            if let runtime = details.runtime {
                self.runtimes[movie.id] = runtime
            }
        } catch {
            print("Error fetching details for movie \(movie.id): \(error)")
        }
    }
}


