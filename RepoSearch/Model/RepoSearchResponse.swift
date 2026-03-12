//
//  RepoSearchResponse.swift
//  RepoSearch
//
//  Created by Sirius Kim on 3/11/26.
//

import Foundation

struct Repo: Codable, Identifiable {
    
    let id: Int
    let name: String
    let owner: Owner
    let html_url: String
}

struct Owner: Codable {
    
    let avatar_url: String
    let login: String
}

struct RepoSearchResponse: Codable {
    
    let total_count: Int
    let items: [Repo]
}
