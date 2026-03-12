//
//  RepoWebView.swift
//  RepoSearch
//

import SwiftUI
import WebKit

struct RepoWebView: View {
    
    let url: URL
    
    var body: some View {
        WebView(url: url)
    }
}
