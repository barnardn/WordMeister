//
//  ContentViewModel.swift
//  
//
//  Created by Norman Barnard on 8/18/22.
//

import Combine
import Foundation
import SwiftUI

public class ContentViewModel: ObservableObject {
    @Published public var searchInput: String = ""
    @Published public var debouncedUserSearch: String = ""
    @Published public var recentSearches: [String] = []
    @Published public var searchResults: [String] = []
    public var startNewSearch: Bool { debouncedUserSearch.count > 3 }
    
    private var cancelables = Set<AnyCancellable>()
    private var searchPrefix = ""
    private let apiClient = WordsAPIClient()

    public init() {
        $searchInput
            .debounce(for: 0.3, scheduler: DispatchQueue.main)
            .assign(to: \.debouncedUserSearch, on: self)
            .store(in: &cancelables)
    }

    @MainActor
    public func startSearch(_ prefix: String) async throws {
        let results = try await apiClient.searchResults(wordPrefix: prefix)
        searchResults = results
    }

    public func cancelSearch() {
        searchInput = ""
        searchResults = []
    }

}

protocol ManagesRecents {
    associatedtype RecentType
    var recents: [RecentType] { get }
    func add(_ item: RecentType) -> [RecentType]
    func clear()
}

public class RecentsManager: ManagesRecents {

    static public let MaxRecents = 10

    private let _recents: CurrentValueSubject<[RecentType], Never>
    var recents: [String] {
        _recents.value
    }

    public init() {
        self._recents = CurrentValueSubject([])
    }

    func add(_ item: String) -> [String] {
        var newRecents = _recents.value
        newRecents.push(item, maxLength: Self.MaxRecents)
        _recents.value = newRecents
        return newRecents
    }

    func clear() {
        _recents.value = []
    }
}
