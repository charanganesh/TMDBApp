//
//  Environment.swift
//  TMDbApp
//
//  Created by Charan Ganesh on 02/11/24.
//

import Foundation

public enum AppConfig {
    
    private static func value(for key: String) -> String {
        guard let value = Bundle.main.object(forInfoDictionaryKey: key) as? String else {
            fatalError("Missing key: \(key) in Info.plist")
        }
        return value
    }
    
    public static let tmdbApiKey: String = {
        value(for: "TMDB_API_KEY")
    }()
    
    public static let baseURL: URL = {
        guard let url = URL(string: value(for: "BASE_URL")) else {
            fatalError("BASE_URL is not a valid URL")
        }
        return url
    }()
    public static let imageBaseURL: URL = {
        guard let url = URL(string: value(for: "IMAGE_BASE_URL")) else {
            fatalError("IMAGE_BASE_URL is not a valid URL")
        }
        return url
    }()
    
    public static let environment: String = {
        value(for: "ENVIRONMENT")
    }()
}
