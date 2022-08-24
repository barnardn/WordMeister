//
//  ContentView.swift
//  WordMeister
//
//  Created by Norman Barnard on 8/17/22.
//

import SwiftUI
import WordmeisterLib

struct ContentView: View {
    @StateObject var viewModel = ContentViewModel()
    var recentSearches: [String]

    @State var showConsole = false

    var body: some View {
        NavigationStack {
            VStack {
                SearchView(recents: recentSearches, cancelAction: { viewModel.cancelSearch() })
                    .searchable(text: $viewModel.searchInput, placement: .navigationBarDrawer, prompt: "Enter a word")
                    .textInputAutocapitalization(.never)
                    .searchSuggestions {
                        SearchSuggestionsView(
                            suggestions: viewModel.searchResults
                        )
                    }
                    .onChange(of: viewModel.debouncedUserSearch, perform: { searchPrefix in
                        if viewModel.startNewSearch {
                            Task {
                                try? await viewModel.startSearch(searchPrefix)
                                try Task.checkCancellation()
                            }
                        }
                    })
                    .navigationTitle("Dixshunairee")
                    .padding()

                Button("Debug") {
                    showConsole = true
                }
                .sheet(isPresented: $showConsole) {
                    NavigationView {
                        DebugConsole()
                    }
                }
            }
        }
    }
}

private struct SearchView: View {
    @Environment(\.isSearching) private var isSearching

    private let recentSearches: [String]
    private let cancelAction: () -> Void

    init(recents: [String], cancelAction: @escaping () -> Void) {
        self.recentSearches = recents
        self.cancelAction = cancelAction
    }

    var body: some View {
        VStack {
            RecentSearchesView(recentSearches)
        }
        .onChange(of: isSearching) { isSearching in
            if !isSearching {
                cancelAction()
            }
        }
    }

}

private struct RecentSearchesView: View {
    private let recentSearches: [String]

    init(_ recentSearches: [String]) {
        self.recentSearches = recentSearches
    }

    var body: some View {
        HStack {
            Text("Recent Searches")
            Spacer()
        }
        List.init(recentSearches, id: \.self) {
            Text($0)
        }
        .listStyle(.plain)
    }
}


private struct SearchSuggestionsView: View {
    let suggestions: [String]
    var body: some View {
        ForEach(suggestions, id: \.self) {
            Text($0)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(recentSearches: ["cat", "dog", "expose"])
    }
}
