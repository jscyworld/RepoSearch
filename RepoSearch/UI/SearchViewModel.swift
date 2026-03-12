//
//  SearchViewModel.swift
//  RepoSearch
//
//  Created by Sirius Kim on 3/11/26.
//

import SwiftUI

extension SearchView {
    
    // MARK: - Properties (Computed)
    
    var autoCompleteSuggestions: [(keyword: String, date: Date)] {
        guard !query.isEmpty else { return [] }
        return recentKeywords
            .filter { $0.key.localizedCaseInsensitiveContains(query) }
            .sorted { $0.value > $1.value }
            .map { (keyword: $0.key, date: $0.value) }
    }
    
    var sortedRecentKeywords: [String] {
        recentKeywords.sorted { $0.value > $1.value }.map(\.key)
    }
    
    
    // MARK: - Function
    
    func clearQuery() {
        query = ""
        clearSearchResult()
    }
    
    func clearHistory() {
        recentKeywords = [:]
        saveHistory()
        clearSearchResult()
    }
    
    func clearSearchResult() {
        service.searchResults.removeAll()
    }
    
    func deleteKeyword(for keyword: String) {
        recentKeywords.removeValue(forKey: keyword)
        saveHistory()
    }
    
    func saveHistory() {
        if let data = try? JSONEncoder().encode(recentKeywords) {
            UserDefaults.standard.set(data, forKey: "recentKeywords")
        }
    }
    
    func setURL(_ urlString: String) {
        selectedURL = URL(string: urlString)
    }
    
    func fetch(for query: String) {
        self.query = query
        fetch()
    }
    
    
    // MARK: - Function (API)
    
    func fetch() {
        isSearchFieldFocused = false
        Task {
            do {
                try await service.search(for: query)
                
                recentKeywords[query] = Date()
                
                if recentKeywords.count > maxHistoryCount {
                    let sorted = recentKeywords.sorted { $0.value > $1.value }.prefix(maxHistoryCount)
                    recentKeywords = Dictionary(uniqueKeysWithValues: sorted.map { ($0.key, $0.value) })
                }
                
                saveHistory()
            } catch {
                fatalError(error.localizedDescription)
            }
        }
    }
    
    func fetchMore() {
        Task {
            do {
                try await service.loadMore()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
