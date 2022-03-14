//
//  ColisionGroup.swift
//  AvianInvaded
//
//  Created by Gabriel Ferreira de Carvalho on 14/03/22.
//

import Foundation

enum ColisionGroup: Int {
    case environment = 1, player = 2, enemy = 3
    
    var uInt32: UInt32 {
        UInt32(self.rawValue)
    }
}
