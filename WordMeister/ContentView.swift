//
//  ContentView.swift
//  WordMeister
//
//  Created by Norman Barnard on 8/17/22.
//

import SwiftUI

struct ContentView: View {
    @State var searchText: String = ""
    @State var selected: String = ""
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
            .searchable(text: $searchText, placement: .navigationBarDrawer, prompt: "Enter a word")
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
