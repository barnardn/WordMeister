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
    private let _recents: CurrentValueSubject<[RecentType], Never>
    var recents: [String] {
        _recents.value
    }

    public init() {
        self._recents = CurrentValueSubject([])
    }

    func add(_ item: String) -> [String] {
        var newRecents = _recents.value
        newRecents.insert(item, at: 0)
        if newRecents.count > 10 {
            newRecents.removeLast(1)
        }
        _recents.value = newRecents
        return newRecents
    }

    func clear() {
        _recents.value = []
    }
}
