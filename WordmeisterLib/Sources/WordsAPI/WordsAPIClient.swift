//
//  WordsAPIClient.swift
//  
//
//  Created by Norman Barnard on 8/20/22.
//

import Foundation

public protocol DictionaryClient {
    func searchResults(wordPrefix: String) async throws -> [String]
    func define(word: String) async throws -> DefinedWord
}

public class WordsAPIClient: DictionaryClient {

    public enum Endpoints { }
    internal enum Models { }

    let networkTransport: NetworkTransport

    public init(networkTransport: NetworkTransport) {
        self.networkTransport = networkTransport
    }

    public func searchResults(wordPrefix: String) async throws -> [String] {
        let endpoint = Endpoints.Search.search(wordPrefix: wordPrefix).apiEndpoint
        async let search: Models.SearchResponse = networkTransport.fetch(request: endpoint.asRequest)
        return try await search.results.data

//        return ["exposable",
//                "exposal",
//                "expose",
//                "exposed",
//                "exposedness",
//                "exposer",
//                "exposing",
//                "exposit",
//                "exposition",
//                "expositional",
//        ]
    }

    public func define(word: String) async throws -> DefinedWord {
        return DefinedWord.preview
    }

}


// MARK: non-model types

extension WordsAPIClient.Models {
    struct SearchResponse: Codable {
        struct Query: Codable {
            let limit: String
            let page: String
        }
        struct Results: Codable {
            let total: String
            let data: [String]
        }
        let query: Query
        let results: Results
    }
}
