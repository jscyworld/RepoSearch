//
//  SearchViewModel.swift
//  RepoSearch
//
//  Created by Sirius Kim on 3/11/26.
//

import SwiftUI

extension SearchView {
    
    // MARK: - Function
    
    func clearQuery() {
        query = ""
        clearSearchResult()
    }
    
    func clearHistory() {
        recentKeywords = []
        saveHistory()
        clearSearchResult()
    }
    
    func clearSearchResult() {
        service.searchResults.removeAll()
    }
    
    func deleteKeyword(for keyword: String) {
        recentKeywords.removeAll { $0 == keyword }
        saveHistory()
    }
    
    func saveHistory() {
        UserDefaults.standard.set(recentKeywords, forKey: "recentKeywords")
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
        Task {
            do {
                try await service.search(for: query)
                
                if !recentKeywords.contains(query) {
                    recentKeywords.insert(query, at: 0)
                }
                
                if recentKeywords.count > maxHistoryCount {
                    recentKeywords = Array(recentKeywords.prefix(maxHistoryCount))
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
