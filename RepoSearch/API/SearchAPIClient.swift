//
//  SearchService.swift
//  RepoSearch
//
//  Created by Sirius Kim on 3/11/26.
//

import Foundation

class SearchAPIClient {
    
    // MARK: - Properties
    
    private let session: URLSession
    private let decoder: JSONDecoder
    
    
    // MARK: - Initializer
    
    init(session: URLSession = .shared, decoder: JSONDecoder = .init()) {
        self.session = session
        self.decoder = decoder
    }
    
    
    // MARK: - Function
    
    func search(for query: String, page: Int = 1) async throws -> RepoSearchResponse {
        
        guard var components = URLComponents(string: "https://api.github.com/search/repositories") else {
            preconditionFailure("Could not create components.")
        }
        
        components.queryItems = [
            URLQueryItem(name: "q", value: query),
            URLQueryItem(name: "page", value: String(page)),
            URLQueryItem(name: "per_page", value: "30")
        ]
        
        guard let url = components.url else {
            preconditionFailure("Could not create URL.")
        }
        
        var request = URLRequest(url: url)
        request.setValue("application/vnd.github+json", forHTTPHeaderField: "Accept")
        request.httpMethod = "GET"
        
        let (data, response) = try await session.data(for: request)
        guard let http = response as? HTTPURLResponse, (200..<300).contains(http.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        let apiResponse = try decoder.decode(RepoSearchResponse.self, from: data)
        return apiResponse
    }
}
