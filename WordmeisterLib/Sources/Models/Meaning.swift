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

    internal init(partOfSpeach: String, definitions: [Definition]) {
        self.partOfSpeach = partOfSpeach
        self.definitions = definitions
    }
}

public struct Definition: Codable, Equatable {
    public let definition: String
    public let synonyms: [String]
    public let antonyms: [String]
    public let example: String?

    internal init(definition: String, synonyms: [String], antonyms: [String], example: String?) {
        self.definition = definition
        self.synonyms = synonyms
        self.antonyms = antonyms
        self.example = example
    }
}


extension Meaning {
    public static var previews: [Meaning] {
        [verb, noun]
    }

    public static var verb: Meaning {
        Meaning(partOfSpeach: "verb", definitions: [Definition.verb])
    }
    public static var noun: Meaning {
        Meaning(partOfSpeach: "noun", definitions: [Definition.noun])
    }

}


extension Definition {
    public static var previews: [Definition] {
        [verb, noun]
    }
    public static var verb: Definition {
        Definition(
            definition: "To run.",
            synonyms: [],
            antonyms: [],
            example: nil
        )
    }
    public static var noun: Definition {
        Definition(
            definition: "Act or instance of running, of moving rapidly using the feet.",
            synonyms: ["synonym"],
            antonyms: ["antonym"],
            example: "I just got back from my morning run."
        )
    }
}
