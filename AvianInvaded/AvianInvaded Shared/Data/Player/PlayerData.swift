//
//  PlayerData.swift
//  AvianInvaded
//
//  Created by Marcos Chevis on 08/03/22.
//

import Foundation
import CoreGraphics

struct PlayerData {
    private(set) var frictionMultiplier: CGFloat = 10
    private(set) var moveMultiplier: CGFloat = 7000
    private(set) var speedLimit: CGFloat = 500
    var shootMagnitude: CGFloat = 8000
    var idleTime: CGFloat = 1
    var walkingTime: CGFloat = 0.4
    var shotCadence: CGFloat = 0.3
    var facingAngle: CGFloat = 0
    var velocity: CGVector = .zero
    private(set) var mass: CGFloat = 1
    //size compared to size of the player sprite
    private(set) var projectileSize = 0.1
    private (set) var scale: CGFloat = 0.14
    
    mutating func reset() {
        frictionMultiplier = 10
        moveMultiplier = 7000
        speedLimit = 500
        mass = 1
        facingAngle = 0
    }
    
    
    mutating func upgradeAcceleration(multiplier: CGFloat) {
        let increase: CGFloat = 1050
        moveMultiplier += (increase*multiplier)
    }
}
