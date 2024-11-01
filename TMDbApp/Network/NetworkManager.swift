//
//  NetworkManager.swift
//  TMDbApp
//
//  Created by Charan Ganesh on 31/10/24.
//

import Foundation

enum HTTPMethod: String {
    case GET
    case POST
}

enum APIError: Error {
    case invalidURL
    case noData
    case decodingError
    case requestFailed
}

final class API {
    
    static let shared = API()
    private init() {}

    func request<T: Decodable>(from url: URL?, method: HTTPMethod, queryParameters: [String: String] = [:], body: Data? = nil) async throws -> T {
        guard var components = URLComponents(url: url ?? URL(string: "")!, resolvingAgainstBaseURL: false) else {
            throw APIError.invalidURL
        }

        var allQueryItems = [
            URLQueryItem(name: "api_key", value: "213b6babae2e0a4efd3712b3d21ceb9f")
        ]
        
        allQueryItems.append(contentsOf: queryParameters.map { URLQueryItem(name: $0.key, value: $0.value) })
        
        components.queryItems = allQueryItems
        
        guard let finalURL = components.url else {
            throw APIError.invalidURL
        }
        
        var request = URLRequest(url: finalURL)
        request.httpMethod = method.rawValue
        request.httpBody = body
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw APIError.requestFailed
        }
        
        do {
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return decodedData
        } catch {
            throw APIError.decodingError
        }
    }
}

