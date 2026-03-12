//
//  AutoCompleteCell.swift
//  RepoSearch
//
//  Created by Sirius Kim on 3/12/26.
//

import SwiftUI

struct AutoCompleteCell: View {
    
    let suggestion: (keyword: String, date: Date)
    
    private var dateText: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM.dd"
        return formatter.string(from: suggestion.date)
    }
    
    var body: some View {
        HStack {
            Text(suggestion.keyword)
            Spacer()
            Text(dateText)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
    }
}

#Preview {
    AutoCompleteCell(suggestion: (keyword: "String", date: Date()))
}
