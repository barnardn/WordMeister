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
    enum Models { }
    enum Constants {}

    let networkTransport: NetworkTransport

    public init(networkTransport: NetworkTransport = URLSession.shared) {
        self.networkTransport = networkTransport
    }

    public func searchResults(wordPrefix: String) async throws -> [String] {
        let endpoint = Endpoints.Search.search(wordPrefix: wordPrefix).apiEndpoint
        do {
            let search: Models.SearchResponse = try await networkTransport.fetch(request: endpoint.asRequest)
            return search.results.data
        } catch {
            print("\(error)")
        }
        return []
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
            let total: Int
            let data: [String]
        }
        let query: Query
        let results: Results
    }
}
