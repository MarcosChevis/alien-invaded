//
//  EnemyData.swift
//  AvianInvaded
//
//  Created by thais on 11/03/22.
//

import Foundation
import CoreGraphics

struct EnemyData{
    
    private(set) var frictionMultiplier: CGFloat = 10
    private(set) var mass: CGFloat = 1
    private(set) var enemyScale: CGFloat = 0.01
    private(set) var moveMultiplier: CGFloat = 500
    var facingAngle: CGFloat = 0
    private(set) var speedLimit: CGFloat = 500
    
    
    mutating func reset() {
        frictionMultiplier = 8
        moveMultiplier = 5000
        speedLimit = 100
        mass = 1
        facingAngle = 0
    }
}

