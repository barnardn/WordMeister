//
//  WordsAPIClient+Endpoints.swift
//  
//
//  Created by Norman Barnard on 8/20/22.
//

import Foundation

public extension WordsAPIClient.Endpoints {
    internal enum Constants {
        static let host = URL(string: "https://wordsapiv1.p.rapidapi.com")!
        static let apiKey = ""
        static let headers: [APIHeader] = [
            .contentType("application/json"),
            .rapidAPIHost(host.absoluteString),
            .rapidAPIKey(apiKey)
        ]
    }

    enum Search {
        case search(wordPrefix: String)

        var apiEndpoint: APIEndpoint {
            switch self {
                case .search(let wordPrefix):
                    return APIEndpoint(
                        host: Constants.host,
                        path: "/words",
                        additionalHeaders: Constants.headers,
                        queryParameters: [
                            .init(name: "letterPattern", value: "^\(wordPrefix)\\w$"),
                            .init(name: "limit", value: "100")
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
                        host: Constants.host,
                        path: "/words/\(word)/definitions",
                        additionalHeaders: Constants.headers
                    )
            }
        }
    }
}
