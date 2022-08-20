//
//  Array+Push.swift
//  
//
//  Created by Norman Barnard on 8/20/22.
//

import Foundation

// TODO: should proabably have this in a different library
public extension Array {
    mutating func push(_ item: Element, maxLength: Int) {
        var newSelf = self
        newSelf.insert(item, at: 0)
        if newSelf.count > maxLength {
            newSelf.removeLast(1)
        }
        self = newSelf
    }
}
