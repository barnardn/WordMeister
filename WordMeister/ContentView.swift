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
    @State var showConsole = false

    var body: some View {
        NavigationStack {
            VStack {
                SearchView(
                    recents: viewModel.recentSearches,
                    isSearchInProgress: $viewModel.isSearchInProgress,
                    cancelAction: { viewModel.cancelSearch() }
                )
                .searchable(text: $viewModel.searchInput, placement: .navigationBarDrawer, prompt: "Enter a word")
                .textInputAutocapitalization(.never)
                .searchSuggestions {
                    ForEach(viewModel.searchResults, id: \.self) { suggestion in
                        SearchSuggestionsView(suggestion: suggestion) {
                            viewModel.selctedWord(word: suggestion)
                            viewModel.cancelSearch()
                        }
                    }
                }
                .onChange(of: viewModel.debouncedUserSearch, perform: { searchPrefix in
                    Task {
                        try? await viewModel.startSearch(searchPrefix)
                        try Task.checkCancellation()
                    }
                })
            }
            .onSubmit(of: .search) {
                print("hi")
            }
            .navigationTitle("Dixshunairee")
            .padding()
        }
    }
}

private struct SearchView: View {
    @Environment(\.isSearching) private var isSearching
    private let isSearchInProgress: Binding<Bool>
    private let recentSearches: [String]
    private let cancelAction: () -> Void

    init(
        recents: [String],
        isSearchInProgress: Binding<Bool>,
        cancelAction: @escaping () -> Void
    ) {
        self.recentSearches = recents
        self.isSearchInProgress = isSearchInProgress
        self.cancelAction = cancelAction
    }

    var body: some View {
        VStack {
            if isSearchInProgress.wrappedValue {
                ProgressView()
                    .progressViewStyle(.circular)
            }
            if !isSearching {
                RecentSearchesView(recentSearches)
            } else {
                VStack {
                    Text("View displayed while searching.")
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .border(.black, width: 1.0)
            }
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
        List(recentSearches, id: \.self) {
            Text($0)
        }
        .listStyle(.plain)
    }
}

private struct SearchSuggestionsView: View {
    @Environment(\.dismissSearch) var dismissSearch
    let suggestion: String
    let onTap: SideEffect

    var body: some View {
        Text(suggestion)
            .onTapGesture {
                onTap()
                dismissSearch()
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
