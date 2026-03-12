//
//  SearchService.swift
//  RepoSearch
//
//  Created by Sirius Kim on 3/11/26.
//

import Foundation
import Combine

final class SearchService: ObservableObject {
    
    // MARK: - Properties
    
    @Published var totalCount: Int = 0
    @Published var searchResults: [Repo] = []
    @Published var isLoading: Bool = false
    
    private let client: SearchAPIClient
    private var currentQuery: String = ""
    private var currentPage: Int = 1
    
    var hasMoreResults: Bool {
        searchResults.count < totalCount
    }
    
    
    // MARK: - Initializer
    
    init(from client: SearchAPIClient) {
        self.client = client
    }
    
    
    // MARK: - Function
    
    func search(for query: String) async throws {
        currentQuery = query
        currentPage = 1
        searchResults = []
        isLoading = true
        defer { isLoading = false }
        
        let response = try await client.search(for: query, page: currentPage)
        totalCount = response.total_count
        searchResults = response.items
    }
    
    func loadMore() async throws {
        guard hasMoreResults, !isLoading else { return }
        isLoading = true
        defer { isLoading = false }
        
        currentPage += 1
        let response = try await client.search(for: currentQuery, page: currentPage)
        searchResults.append(contentsOf: response.items)
    }
}
