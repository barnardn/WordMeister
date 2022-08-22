//
//  WordsAPIClient+Endpoints.swift
//  
//
//  Created by Norman Barnard on 8/20/22.
//

import Foundation

public extension WordsAPIClient.Endpoints {
    enum Search {
        case search(wordPrefix: String)

        var apiEndpoint: APIEndpoint {
            switch self {
            case .search(let wordPrefix):
                return APIEndpoint(
                    host: WordsAPIClient.Constants.host,
                    path: .directory("/words"),
                    additionalHeaders: WordsAPIClient.Constants.headers,
                    queryParameters: [
                        .init(name: "letterPattern", value: "^\(wordPrefix)\\w*$"),
                        .init(name: "limit", value: "20"),
                        .init(name: "page", value: "1")
                    ]
                )
            }
        }
    }

    enum Definitions {
        case define(word: String)

        var apiEndpoint: APIEndpoint {
            switch self {
            case .define(let word):
                return APIEndpoint(
                    host: WordsAPIClient.Constants.host,
                    path: .resource("/words/\(word)/definitions"),
                    additionalHeaders: WordsAPIClient.Constants.headers
                )
            }
        }
    }
}
