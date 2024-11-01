//
//  BaseURL.swift
//  TMDbApp
//
//  Created by Charan Ganesh on 01/11/24.
//

import Foundation

struct BaseURL {
    static let base = "https://api.themoviedb.org/3"
    
    // Base Endpoints
    static var popularMovies: URL? {
        URL(string: "\(base)/movie/popular")
    }
    
    static func movieDetails(for movieID: Int) -> URL? {
        URL(string: "\(base)/movie/\(movieID)")
    }
    
    static func movieTrailer(for movieID: Int) -> URL? {
        URL(string: "\(base)/movie/\(movieID)/videos")
    }
    
    // Image Base URL (e.g., for poster or profile images)
    static func imageURL(path: String, size: ImageSize = .w200) -> URL? {
        URL(string: "https://image.tmdb.org/t/p/\(size)\(path)")
    }
}
