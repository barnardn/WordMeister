//
//  Definition.swift
//  
//
//  Created by Norman Barnard on 8/17/22.
//

import Foundation

public struct Definition: Codable, Equatable {
    public let definition: String
    public let partOfSpeech: String
    public let synonyms: [String]?
    public let typeOf: [String]?
    public let derivation: [String]?
    public let examples: [String]?

    internal init(
        definition: String,
        partOfSpeech: String,
        synonyms: [String]?,
        typeOf: [String]?,
        derivation: [String]?,
        examples: [String]?
    ) {
        self.definition = definition
        self.partOfSpeech = partOfSpeech
        self.synonyms = synonyms
        self.typeOf = typeOf
        self.derivation = derivation
        self.examples = examples
    }

}

public extension Definition {
    static var previews: [Definition] { [verb, noun] }

    static var verb: Definition {
        Definition(
            definition: "move fast by using one's feet, with one foot off the ground at any given time",
            partOfSpeech: "verb",
            synonyms: ["synonym"],
            typeOf: [],
            derivation: [],
            examples: ["I had to run to catch the bus."]
        )
    }
    static var noun: Definition {
        Definition(
            definition: "a small stream",
            partOfSpeech: "noun",
            synonyms: ["rivulet", "streamlet"],
            typeOf: ["stream"],
            derivation: [],
            examples: []
        )
    }
}
