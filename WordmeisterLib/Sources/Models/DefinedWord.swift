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
    public let phonetics: [Phonetics]
    public let meanings: [Meaning]
    public let sourceUrls: [URL?]?

    internal init(word: String, phonetics: [Phonetics], meanings: [Meaning], sourceUrls: [URL?]?) {
        self.word = word
        self.phonetics = phonetics
        self.meanings = meanings
        self.sourceUrls = sourceUrls
    }
}

extension DefinedWord {
    public static var preview: DefinedWord {
        DefinedWord(
            word: "run",
            phonetics: Phonetics.previews,
            meanings: Meaning.previews,
            sourceUrls: [
                URL(string: "https://en.wiktionary.org/wiki/rin"),
                URL(string: "https://en.wiktionary.org/wiki/riun")
            ]
        )
    }
}
