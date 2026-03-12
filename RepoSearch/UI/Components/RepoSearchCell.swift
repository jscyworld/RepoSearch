//
//  RepoSearchCell.swift
//  RepoSearch
//
//  Created by Sirius Kim on 3/11/26.
//

import SwiftUI

struct RepoSearchCell: View {
    
    // MARK: - Properties
    
    let repo: Repo
    
    
    // MARK: - UI
    
    var body: some View {
        HStack {
            avatarImage
                .frame(width: 50, height: 50)
            VStack(alignment: .leading) {
                Text(repo.name)
                    .font(.headline)
                Text(repo.owner.login)
                    .font(.subheadline)
            }
            Spacer()
        }
        .padding(.bottom, 8.0)
    }
    
    private var avatarImage: some View {
        AsyncImage(url: URL(string: repo.owner.avatar_url)) { phase in
            switch phase {
            case .empty:
                Color.gray.opacity(0.2)
                    .overlay(ProgressView())
            case .success(let image):
                image
                    .resizable()
                    .scaledToFit()
            case .failure:
                Color.gray.opacity(0.2)
            @unknown default:
                Color.gray.opacity(0.2)
            }
        }
    }
}

#Preview {
    RepoSearchCell(repo: .init(id: 44838949, name: "swift", owner: .init(avatar_url: "https://avatars.githubusercontent.com/u/42816656?v=4", login: "swiftlang"), html_url: "https://github.com/swiftlang/swift"))
}
