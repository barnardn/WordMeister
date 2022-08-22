//
//  WordsAPIClient+Constants.swift
//  
//
//  Created by Norman Barnard on 8/22/22.
//

import Foundation

extension WordsAPIClient.Constants {

    static var host = URL(string: "https://wordsapiv1.p.rapidapi.com")!
    static var apiKey = ""
    static let headers: [APIHeader] = [
        .contentType("application/json"),
        .rapidAPIHost(host.host ?? ""),
        .rapidAPIKey(apiKey)
    ]

}
