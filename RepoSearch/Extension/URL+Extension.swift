//
//  URL+Extension.swift
//  RepoSearch
//
//  Created by Sirius Kim on 3/11/26.
//

import Foundation

extension URL: @retroactive Identifiable {
    public var id: String { absoluteString }
}
