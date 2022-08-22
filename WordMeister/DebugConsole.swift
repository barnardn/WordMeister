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
// https://wordsapiv1.p.rapidapi.com/words/?letterPattern=%5Eexpo%5Cw%2B%24&limit=100&page=1
private struct SearchTestView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject var viewModel = ContentViewModel()

    var body: some View {
        VStack(alignment: .center, spacing: 10.0) {
            TextField("Search Term", text: $viewModel.userSearch)
                .textFieldStyle(.roundedBorder)
                .autocapitalization(.none)
                .textCase(.lowercase)
                .autocorrectionDisabled()
                .onSubmit {
                    Task {
                        try await viewModel.startSearch()
                    }
                }
            HStack {
                Text("Results")
                    .foregroundColor(.gray)
                Spacer()
            }
            .padding(.leading, 8)
            Spacer()
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
