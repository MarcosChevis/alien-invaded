//
//  EnemyData.swift
//  AvianInvaded
//
//  Created by thais on 11/03/22.
//

import Foundation
import CoreGraphics

struct EnemyData {
    
    private(set) var frictionMultiplier: CGFloat = 10
    private(set) var mass: CGFloat = 1
    private(set) var scale: CGFloat = 0.1
    private(set) var moveMultiplier: CGFloat = 500
    var facingAngle: CGFloat = 0
    private(set) var speedLimit: CGFloat = 500
    private(set) var projectileSize: CGFloat = 0.3
    private(set) var attackDistance: CGFloat = 1000
    private(set) var distanceEnemyFromPlayer: CGFloat = 200
    private(set) var shootCadence: CGFloat = 0.8
    private(set) var shootingMagnitude: CGFloat = 2000
    private(set) var maxHealth: CGFloat = 10
    var currentHealth: CGFloat = 10
    private(set) var projectileDamage: CGFloat = 1

    mutating func resetFrictionMultiplier() {
        frictionMultiplier = 10
    }
    
    mutating func resetMass() {
        mass = 1
    }
    
    mutating func resetScale() {
        scale = 1
    }
    
    mutating func resetMoveMultiplier() {
        moveMultiplier = 500
    }
    
    mutating func resetSpeedLimit() {
        speedLimit = 500
    }
    
    mutating func resetProjectileSize() {
        projectileSize = 0.1
    }
    
    mutating func resetAttackDistance() {
        attackDistance = 1000
    }
    
    mutating func resetDistanceEnemyFromPlayer() {
        distanceEnemyFromPlayer = 200
    }
    
    mutating func resetShootCadence() {
        shootCadence = 0.7
    }
    
    mutating func resetShootingMagnitude() {
        shootingMagnitude = 700
    }
    
    mutating func resetMaxHealth() {
        maxHealth = 10
    }
    
    mutating func resetCurrentHealth() {
        currentHealth = 1
    }
    
    mutating func resetProjectileDemage() {
        projectileDamage = 1
    }
    
    mutating func resetAll() {
        resetFrictionMultiplier()
        resetMass()
        resetScale()
        resetMoveMultiplier()
        resetSpeedLimit()
        resetProjectileSize()
        resetAttackDistance()
        resetDistanceEnemyFromPlayer()
        resetShootCadence()
        resetShootingMagnitude()
        resetMaxHealth()
        resetCurrentHealth()
        resetProjectileDemage()
    }
    
    mutating func upgradeAcceleration(multiplier: CGFloat) {
        let increase: CGFloat = 0.2
        moveMultiplier += (increase * multiplier)
    }
    
    mutating func upgradeMaxSpeed(multiplier: CGFloat) {
        let increase: CGFloat = 35
        speedLimit += (increase * multiplier)
    }
    
    mutating func upgradeProjectileSize(multiplier: CGFloat) {
        let increase: CGFloat = 0.2
        projectileSize += (increase * multiplier)
    }
    
    mutating func upgradeAttackDistance(multiplier: CGFloat) {
        let increase: CGFloat = 1
        attackDistance += (increase * multiplier)
    }
    
    mutating func upgradeMaxHealth(multiplier: CGFloat) {
        let increase: CGFloat = 0.1
        maxHealth += (increase * multiplier)
    }
    
    mutating func upgradeCurrentHealth(multiplier: CGFloat) {
        let increase: CGFloat = 0.2
        currentHealth += (increase * multiplier)
    }
    
    mutating func upgradeProjectileDamage(multiplier: CGFloat) {
        let increase: CGFloat = 0.5
        projectileDamage += (increase * multiplier)
    }
}
