//
//  MovieDetailViewModel.swift
//  TMDbApp
//
//  Created by Charan Ganesh on 31/10/24.
//

import Foundation
import Observation

@Observable
final class MovieDetailViewModel {
    var movieDetail: MovieDetailModel?
    var movieTrailer: MovieDetailVideoModel?
    var errorMessage: String?
    var isLoading = true
    
    private let movieService: MovieServiceProtocol
    
    init(movieService: MovieServiceProtocol = MovieService()) {
        self.movieService = movieService
    }
    
    func fetchDetails(for movieID: Int) async {
        isLoading = true
        do {
            self.movieDetail = try await movieService.fetchMovieDetails(movieID: movieID)
            self.movieTrailer = try await movieService.fetchMovieTrailer(movieID: movieID)
            isLoading = false
        } catch {
            self.errorMessage = "Failed to fetch data: \(error)"
            print(errorMessage ?? "")
            isLoading = false
        }
    }
    var mainCast: [Cast] {
        movieDetail?.credits?.cast.filter { $0.knownForDepartment == .acting }
            .sorted { ($0.order ?? Int.max) < ($1.order ?? Int.max) } ?? []
    }
}
