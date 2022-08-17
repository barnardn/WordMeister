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
}
