//
//  PlayerData.swift
//  AvianInvaded
//
//  Created by Marcos Chevis on 08/03/22.
//

import Foundation
import CoreGraphics

struct PlayerData {
    
    //movement variables
    private(set) var frictionMultiplier: CGFloat = 10
    private(set) var moveMultiplier: CGFloat = 7000
    private(set) var speedLimit: CGFloat = 400

    //shot variables
    private(set) var shootMagnitude: CGFloat = 5000
    private(set) var shotCadence: CGFloat = 0.5
    //size compared to size of the player sprite
    private(set) var projectileSize = 0.1
    
    //others
    private (set) var scale: CGFloat = 0.14
    private(set) var mass: CGFloat = 1
    
    //animation and logic variables
    var facingAngle: CGFloat = 0
    var idleTime: CGFloat = 1
    var walkingTime: CGFloat = 0.4
    var velocity: CGVector = .zero
    
    private(set) var maxHealth: CGFloat = 10
    var currentHealth: CGFloat = 10
    
    mutating func resetFrictionMultiplier() {
        frictionMultiplier = 10
    }
    
    mutating func resetMoveMultiplier() {
        moveMultiplier = 7000
    }
    
    mutating func resetSpeedLimit() {
        speedLimit = 400
    }
    
    mutating func resetMass() {
        mass = 1
    }
    
    mutating func resetShootMagnitude() {
        shootMagnitude = 5000
    }
    
    mutating func resetShotCadence() {
        shotCadence = 0.5
    }
    
    mutating func resetProjectileSize() {
        projectileSize = 0.1
    }
    
    mutating func resetMaxHealth() {
        maxHealth = 10
    }
    
    mutating func resetCurrentHealth() {
        currentHealth = maxHealth
    }
    
    mutating func resetScale() {
        scale = 0.14
    }
    
    mutating func resetAll() {
        resetFrictionMultiplier()
        resetMoveMultiplier()
        resetSpeedLimit()
        resetMass()
        resetShootMagnitude()
        resetShotCadence()
        resetProjectileSize()
        resetMaxHealth()
        resetCurrentHealth()
        resetScale()
    }
    
    mutating func upgradeAcceleration(multiplier: CGFloat) {
        //7.14% of initial value
        let increase: CGFloat = 500
        moveMultiplier += (increase * multiplier)
    }
    
    mutating func upgradeMaxSpeed(multiplier: CGFloat) {
        //7% of initial value
        let increase: CGFloat = 35
        speedLimit += (increase * multiplier)
    }
    
    mutating func upgradeShotSpeed(multiplier: CGFloat) {
        //
        let increase: CGFloat = 225
        shootMagnitude += (increase * multiplier)
    }
    
    mutating func upgradeShotCadence(multiplier: CGFloat) {
        let decrease: CGFloat = 0.9
        
        shotCadence *= (decrease / multiplier)
    }
    
    mutating func upgradeShotSize(multiplier: CGFloat) {
        let increase: CGFloat = 0.02
        
        projectileSize += (increase * multiplier)
    }
    
    mutating func upgradeMaxHealth(multiplier: CGFloat) {
        let increase: CGFloat = 1
        maxHealth += (increase * multiplier)
    }
    
    mutating func upgradeCurrentHealth(multiplier: CGFloat) {
        let increase: CGFloat = 1
        currentHealth += (increase * multiplier)
    }
}
