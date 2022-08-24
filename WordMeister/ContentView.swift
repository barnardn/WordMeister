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
    var recentSearches: [String]

    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("Recent Searches")
                    Spacer()
                }
                List.init(recentSearches, id: \.self) {
                    Text($0)
                }
                .listStyle(.plain)
                Button("Debug") {
                    showConsole = true
                }
                .sheet(isPresented: $showConsole) {
                    NavigationView {
                        DebugConsole()
                    }
                }
            }
            .searchable(text: $viewModel.userSearch, placement: .navigationBarDrawer, prompt: "Enter a word")
            .onChange(of: viewModel.debouncedUserSearch.count, perform: { newValue in
                if newValue > 3 {
                    Task {
                        try? await viewModel.startSearch()
                    }
                }
            })
            .textInputAutocapitalization(.never)
            .searchSuggestions {
                if viewModel.searchResults.isEmpty {
                    HStack {
                        ProgressView()
                            .progressViewStyle(.circular)
                    }
                    .frame(maxWidth: .infinity)
                } else {
                    ForEach(viewModel.searchResults, id: \.self) {
                        Text($0)
                    }
                }
            }
            .navigationTitle("Word Meister")
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(recentSearches: ["cat", "dog", "expose"])
    }
}
