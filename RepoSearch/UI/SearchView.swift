//
//  ContentView.swift
//  RepoSearch
//
//  Created by JSS_MacBookPro on 3/10/26.
//

import SwiftUI

struct SearchView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject var service: SearchService
    
    @State var query: String = ""
    @State var recentKeywords: [String: Date] = {
        guard let data = UserDefaults.standard.data(forKey: "recentKeywords"),
              let decoded = try? JSONDecoder().decode([String: Date].self, from: data) else {
            return [:]
        }
        return decoded
    }()
    @State var selectedURL: URL?
    @FocusState var isSearchFieldFocused: Bool
    
    let maxHistoryCount: Int = 10
    
    
    // MARK: - UI
    
    var body: some View {
        NavigationView {
            VStack {
                searchField
                    .padding(10.0)
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 10))
                if isSearchFieldFocused && !autoCompleteSuggestions.isEmpty {
                    autoCompletePanel
                }
                Spacer().frame(height: 24.0)
                if !service.searchResults.isEmpty && !query.isEmpty {
                    repoView
                }
                if query.isEmpty && !recentKeywords.isEmpty {
                    recentView
                    Divider()
                    Spacer()
                } else {
                    Spacer()
                }
            }
            .padding()
            .navigationTitle("Search")
            .sheet(item: $selectedURL) { url in
                NavigationView {
                    RepoWebView(url: url)
                        .ignoresSafeArea()
                        .toolbar {
                            ToolbarItem(placement: .cancellationAction) {
                                ShareLink(item: url)
                            }
                            ToolbarItem(placement: .confirmationAction) {
                                Button("Done") { selectedURL = nil }
                            }
                        }
                }
            }
        }
    }
    
    
    // MARK: - UI (SearchField)
    
    private var searchField: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(.secondary)
            TextField("저장소 검색", text: $query, onCommit: fetch)
                .focused($isSearchFieldFocused)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
            if !query.isEmpty {
                Button(action: clearQuery) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(.secondary)
                }
                .buttonStyle(.plain)
            }
        }
    }
    
    
    // MARK: - UI (AutoComplete)
    
    private var autoCompletePanel: some View {
        VStack(spacing: 0.0) {
            ForEach(autoCompleteSuggestions, id: \.keyword) { suggestion in
                Button(action: { fetch(for: suggestion.keyword) }) {
                    AutoCompleteCell(suggestion: suggestion)
                }
                .buttonStyle(.plain)
            }
        }
    }
    
    
    // MARK: - UI (RepoView)
    
    private var repoView: some View {
        VStack(alignment: .leading) {
            Text("\(service.totalCount) repositories")
            ScrollView {
                LazyVStack {
                    ForEach(service.searchResults) { repo in
                        Button(action: { setURL(repo.html_url) }) {
                            RepoSearchCell(repo: repo)
                        }
                        .buttonStyle(.plain)
                        .onAppear {
                            if repo.id == service.searchResults.last?.id {
                                fetchMore()
                            }
                        }
                    }
                    if service.isLoading {
                        ProgressView()
                            .padding()
                    }
                }
            }
            .scrollIndicators(.never)
        }
    }
    
    
    // MARK: - UI (RecentView)
    
    private var recentView: some View {
        VStack(alignment: .leading) {
            Text("최근 검색")
                .font(.subheadline)
                .padding(.bottom, 24.0)
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 4.0), count: 3), alignment: .leading, spacing: 16.0) {
                ForEach(sortedRecentKeywords, id: \.self) { keyword in
                    Button(action: { fetch(for: keyword) }) {
                        RecentKeywordCell(keyword: keyword, handler: { deleteKeyword(for: keyword) })
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.bottom, 16.0)
            HStack {
                Spacer()
                Button(action: clearHistory) {
                    Text("전체삭제")
                        .font(.subheadline)
                        .foregroundStyle(.red)
                }
            }
        }
    }
}

#Preview {
    SearchView()
        .environmentObject(SearchService(from: SearchAPIClient.init()))
}
