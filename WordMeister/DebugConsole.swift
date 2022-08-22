//
//  DebugConsole.swift
//  WordMeister
//
//  Created by Norman Barnard on 8/21/22.
//

import SwiftUI
import WordmeisterLib

struct DebugConsole: View {
    var body: some View {
        SearchTestView()
    }
}

private struct SearchTestView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject var viewModel = ContentViewModel()

    var body: some View {
        VStack(alignment: .center, spacing: 10.0) {
            TextField("Search Term", text: $viewModel.userSearch)
                .textFieldStyle(.roundedBorder)
                .autocapitalization(.none)
                .autocorrectionDisabled()
                .onSubmit {
                    Task {
                        try await viewModel.startSearch()
                    }
                }
            if !viewModel.searchResults.isEmpty {
                List {
                    Section(
                        content: {
                            ForEach(viewModel.searchResults, id: \.self) {
                                Text($0)
                            }
                        },
                        header: { Text("Results") }
                    )
                }
                .listStyle(.plain)
            } else {
                Spacer()
            }
        }
        .padding()
        .navigationBarItems(
            leading:
                Button("Cancel") { dismiss() }
        )
        .navigationBarTitle("Debug Console", displayMode: .inline)
    }
}


struct DebugConsole_Previews: PreviewProvider {
    static var previews: some View {
        DebugConsole()
    }
}
