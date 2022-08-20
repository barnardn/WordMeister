//
//  ContentViewModel.swift
//  
//
//  Created by Norman Barnard on 8/18/22.
//

import Combine
import Foundation
import SwiftUI
import WordMeister

public class ContentViewModel: ObservableObject {
    @Published var userSearch: String = ""
    @Published var recentSearches: [String] = []

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
