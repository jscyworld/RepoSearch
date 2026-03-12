//
//  RecentKeywordCell.swift
//  RepoSearch
//
//  Created by Sirius Kim on 3/11/26.
//

import SwiftUI

struct RecentKeywordCell: View {
    
    // MARK: - Properties
    
    let keyword: String
    let handler: (() -> Void)
    
    
    // MARK: - UI
    
    var body: some View {
        HStack(spacing: 16.0) {
            Text(keyword)
                .foregroundColor(.secondary)
            Button(action: handler) {
                Image(systemName: "xmark.circle.fill")
                    .foregroundStyle(.gray)
            }
            .buttonStyle(.plain)
        }
    }
}

#Preview {
    RecentKeywordCell(keyword: "Swift", handler: {})
}
