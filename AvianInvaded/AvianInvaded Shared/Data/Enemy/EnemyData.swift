//
//  EnemyData.swift
//  AvianInvaded
//
//  Created by thais on 11/03/22.
//

import Foundation
import CoreGraphics

struct EnemyData{
    
    private(set) var mass: CGFloat = 1
    private(set) var enemyScale: CGFloat = 0.01
    var facingAngle: CGFloat = 0
    
    mutating func reset() {
        mass = 1
    }
}

