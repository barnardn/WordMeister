//
//  Phonetics.swift
//  
//
//  Created by Norman Barnard on 8/17/22.
//

import Foundation

public struct Phonetics: Codable, Equatable {
    public let audio: URL?
    public let text: String?
    public let sourceURL: URL?
    public let license: License?
    
    internal init(audio: URL? = nil, text: String? = nil, sourceURL: URL? = nil, license: License? = nil) {
        self.audio = audio
        self.text = text
        self.sourceURL = sourceURL
        self.license = license
    }
}

extension Phonetics {
    public static var previews: [Phonetics] {
        return [preview, textOnly]
    }

    public static var preview: Phonetics {
        Phonetics(
            audio: URL(string: "https://api.dictionaryapi.dev/media/pronunciations/en/run-us.mp3"),
            text: "/ɹʌn/",
            sourceURL: URL(string: "https://commons.wikimedia.org/w/index.php?curid=646000"),
            license: .preview
        )
    }

    public static var textOnly: Phonetics {
        Phonetics(
            audio: URL(string: "https://api.dictionaryapi.dev/media/pronunciations/en/run-us.mp3"),
            text: "/ɹʌn/",
            sourceURL: nil,
            license: nil
        )
    }
}
