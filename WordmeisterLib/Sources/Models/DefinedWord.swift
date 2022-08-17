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
    public let sourceUrls: [URL]
}
