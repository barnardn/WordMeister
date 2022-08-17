//
//  Meaning.swift
//  
//
//  Created by Norman Barnard on 8/17/22.
//

import Foundation

public struct Meaning: Codable, Equatable {
    public let partOfSpeach: String
    public let definitions: [Definition]
}

public struct Definition: Codable, Equatable {
    public let definition: String
    public let synonyms: [String]
    public let antonyms: [String]
    public let example: String
}
