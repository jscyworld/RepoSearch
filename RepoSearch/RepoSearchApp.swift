//
//  RepoSearchApp.swift
//  RepoSearch
//
//  Created by JSS_MacBookPro on 3/10/26.
//

import SwiftUI

@main
struct RepoSearchApp: App {
    
    // MARK: - Properties
    
    let service: SearchService
    let client: SearchAPIClient
    
    
    // MARK: - Initializer
    
    init() {
        self.client = .init()
        self.service = .init(from: client)
    }
    
    
    // MARK: - App
    
    var body: some Scene {
        WindowGroup {
            SearchView()
                .environmentObject(service)
        }
    }
}
