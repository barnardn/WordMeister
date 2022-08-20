//
//  DefinedWord.swift
//  
//
//  Created by Norman Barnard on 8/17/22.
//

import Foundation

public struct DefinedWord: Identifiable, Codable, Equatable {
    public var id: String { word }
    public let word: String
    public let definitions: [Definition]
    public let syllables: Syllables
    public let pronunciation: Pronunciation

    internal init(word: String, definitions: [Definition], syllables: Syllables, pronunciation: Pronunciation) {
        self.word = word
        self.definitions = definitions
        self.syllables = syllables
        self.pronunciation = pronunciation
    }

    enum CodingKeys: String, CodingKey {
        case word
        case definitions = "results"
        case syllables
        case pronunciation
    }
}

extension DefinedWord {
    public static var preview: DefinedWord {
        DefinedWord(
            word: "run",
            definitions: Definition.previews,
            syllables: .preview,
            pronunciation: .preview
        )
    }
}

public struct Syllables: Codable, Equatable {
    public let count: Int
    public let syllables: [String]

    internal init(count: Int, syllables: [String]) {
        self.count = count
        self.syllables = syllables
    }
}

public extension Syllables {
    static var preview: Syllables {
        Syllables(count: 3, syllables: ["ex", "am", "ple"])
    }
}


public struct Pronunciation: Codable, Equatable {
    public let all: String

    internal init(all: String) {
        self.all = all
    }
}

public extension Pronunciation {
    static var preview: Pronunciation{
        Pronunciation(all: "ɪɡ'zæmpəl")
    }
}
