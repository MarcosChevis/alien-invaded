//
//  Int+RandomList.swift
//  AvianInvaded
//
//  Created by Gabriel Ferreira de Carvalho on 22/03/22.
//

import Foundation

extension Int {
    static func randomList(maxValue: Int, listSize: Int) -> [Int] {
        if listSize == 0 { return [] }
        if listSize == 1 { return [maxValue] }
        
        var currentMax = maxValue
        
        return Array(repeating: 0, count: listSize)
            .enumerated()
            .map { index, _ in
                if index == listSize-1 {
                    return currentMax
                }
                
                let random = Int.random(in: 0...currentMax)
                currentMax -= random
                
                return random
            }
    }
}
