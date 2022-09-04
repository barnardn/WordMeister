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
    @Published public var isSearchInProgress: Bool = false
    @Published public var recentSearches: [String] = []
    @Published public var searchResults: [String] = []

    private let recentManager: RecentsManager<String>

    private var cancelables = Set<AnyCancellable>()
    private var searchPrefix = ""
    private let apiClient = WordsAPIClient()

    public init(
        recentsManager: RecentsManager<String> = RecentsManager()
    ) {
        self.recentManager = recentsManager
        self.recentSearches = recentManager.recents

        $searchInput
            .debounce(for: 0.3, scheduler: DispatchQueue.main)
            .assign(to: \.debouncedUserSearch, on: self)
            .store(in: &cancelables)
    }

    @MainActor
    public func startSearch(_ prefix: String) async throws {
        isSearchInProgress = !prefix.isEmpty
        guard !prefix.isEmpty else {
            cancelSearch()
            return
        }

        defer { isSearchInProgress = false }
        let results = try await apiClient.searchResults(wordPrefix: prefix)
        searchResults = results
    }

    public func selctedWord(word: String) {
        recentSearches = recentManager.add(word)
    }

    public func cancelSearch() {
        searchInput = ""
        searchResults = []
        isSearchInProgress = false
    }

}

public class RecentsManager<T> {

    private let _recents: CurrentValueSubject<[T], Never>
    var recents: [T] {
        _recents.value
    }

    public init() {
        self._recents = CurrentValueSubject([])
    }

    func add(_ item: T) -> [T] {
        var newRecents = _recents.value
        newRecents.push(item, maxLength: 10)
        _recents.value = newRecents
        return newRecents
    }

    func clear() {
        _recents.value = []
    }
}
