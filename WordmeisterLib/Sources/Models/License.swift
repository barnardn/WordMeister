//
//  Licence.swift
//  
//
//  Created by Norman Barnard on 8/17/22.
//

import Foundation

public struct License: Codable, Equatable {
    public let name: String
    public let url: URL?

    internal init(name: String, url: URL?) {
        self.name = name
        self.url = url
    }
}

extension License {
    public static var preview: License {
        License(
            name: "CC BY-SA 3.0",
            url: URL(string: "https://creativecommons.org/licenses/by-sa/3.0")
        )
    }
}
