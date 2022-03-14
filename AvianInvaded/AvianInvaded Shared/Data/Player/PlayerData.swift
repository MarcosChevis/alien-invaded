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
    var facingAngle: CGFloat = 0
    private(set) var mass: CGFloat = 1
    private(set) var playerScale: CGFloat = 0.33
    //var angularVelocity: CGFloat = 0
    
    mutating func reset() {
        frictionMultiplier = 10
        moveMultiplier = 7000
        speedLimit = 500
        mass = 1
        facingAngle = 0
    }
}
