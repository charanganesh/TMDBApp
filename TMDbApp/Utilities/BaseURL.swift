//
//  BaseURL.swift
//  TMDbApp
//
//  Created by Charan Ganesh on 01/11/24.
//

import Foundation

struct BaseURL {
    
    static var popularMovies: URL? {
        AppConfig.baseURL.appendingPathComponent("/movie/popular")
    }
    
    static func movieDetails(for movieID: Int) -> URL? {
        AppConfig.baseURL.appendingPathComponent("/movie/\(movieID)")
    }
    
    static func movieTrailer(for movieID: Int) -> URL? {
        AppConfig.baseURL.appendingPathComponent("/movie/\(movieID)/videos")
    }
    
    // Image Base URL (e.g., for poster or profile images)
    static func imageURL(path: String, size: ImageSize = .w200) -> URL? {
        AppConfig.imageBaseURL.appendingPathComponent("\(size)\(path)")
    }
}
