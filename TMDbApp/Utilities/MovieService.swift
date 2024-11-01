//
//  MovieServiceProtocol.swift
//  TMDbApp
//
//  Created by Charan Ganesh on 31/10/24.
//

import Foundation

protocol MovieServiceProtocol {
    func fetchPopularMovies(page: Int) async throws -> MovieModel
    func fetchMovieDetails(movieID: Int) async throws -> MovieDetailModel
    func fetchMovieTrailer(movieID: Int) async throws -> MovieDetailVideoModel
}

final class MovieService: MovieServiceProtocol {
    
    func fetchPopularMovies(page: Int = 1) async throws -> MovieModel {
        guard let url = BaseURL.popularMovies else {
            throw APIError.invalidURL
        }
        let movieModel: MovieModel = try await API.shared.request(from: url, method: .GET, queryParameters: ["page": "\(page)"])
        return movieModel
    }
    
    func fetchMovieDetails(movieID: Int) async throws -> MovieDetailModel {
        guard let url = BaseURL.movieDetails(for: movieID) else {
            throw APIError.invalidURL
        }
        return try await API.shared.request(from: url, method: .GET, queryParameters: ["append_to_response": "credits"])
    }
    
    func fetchMovieTrailer(movieID: Int) async throws -> MovieDetailVideoModel {
        guard let url = BaseURL.movieTrailer(for: movieID) else {
            throw APIError.invalidURL
        }
        return try await API.shared.request(from: url, method: .GET)
    }
}
