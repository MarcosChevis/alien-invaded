//
//  PlayerLogic.swift
//  AvianInvaded
//
//  Created by Marcos Chevis on 07/03/22.
//

import UIKit
import Foundation
import CoreGraphics
import SpriteKit
import GameplayKit

class PlayerLogicController: LifeCycleElement {
    
    weak var delegate: PlayerLogicDelegate?
    weak var hudDelegate: PlayerHudDelegate?
    weak var playerStateDelegate: PlayerStateDelegate?
    
    var inputController: InputControllerProtocol
    var data: PlayerData
    
    private var timeLastShot: TimeInterval
    
    var mass: CGFloat { data.mass }
    var scale: CGFloat { data.scale }
    
    private let notificationCenter: NotificationCenter
    
    private var timeLastDamageTaken: TimeInterval
    private var currentTime: TimeInterval
        
    init(data: PlayerData = .init(),
         inputController: InputControllerProtocol,
         notificationCenter: NotificationCenter) {
        
        self.data = data
        self.inputController = inputController
        self.timeLastShot = 0
        self.notificationCenter = notificationCenter
        self.currentTime = 0
        self.timeLastDamageTaken = -.greatestFiniteMagnitude
        self.inputController.delegate = self
    }
    
    func update(_ currentTime: TimeInterval) {
        self.currentTime = currentTime
        inputController.update(currentTime)
        
    }
    
    func reset() {
        data.resetAll()
    }
    
    func rotateBody(to angle: CGFloat) {
        data.facingAngle = angle
        delegate?.rotateBody(to: angle)
    }
    
    func rotateLegs(to angle: CGFloat) {
        delegate?.rotateLegs(to: angle)
    }
    
    func apply(force vector: CGVector, currentVelocity: CGVector) -> CGVector? {
        if currentVelocity.magnitude < data.speedLimit {
            return vector * data.moveMultiplier
        } else {
            return nil
        }
    }
    
    func sendPlayerDidMove(newPosition: CGPoint) {
        notificationCenter.post(name: .playerDidMove, object: newPosition)
    }
    
    func loseHealth(_ amount: CGFloat) {
        if abs(currentTime - timeLastDamageTaken) > data.timeInvulnerable {
            delegate?.takeDamage(duration: data.timeInvulnerable)
            timeLastDamageTaken = currentTime
            data.currentHealth -= amount
            hudDelegate?.updateHealth(data.currentHealth/data.maxHealth)
            if data.currentHealth <= 0 {
                playerStateDelegate?.playerDidDie()
            }
            print(data.currentHealth)
        }
    }
    
    func gainHealth(_ amount: CGFloat) {
        data.currentHealth += amount
        hudDelegate?.updateHealth(data.currentHealth/data.maxHealth)
    }
    
    func gainXp() {
        data.currentXp += 0.1
        hudDelegate?.updateExperience(data.currentXp)
        if data.currentXp >= 1 {
            upgrade()
            data.currentXp = 0
            playerStateDelegate?.playerDidUpgrade()
        }
    }
    
    func loseXp() {
        data.currentXp -= 0.1
        hudDelegate?.updateExperience(data.currentXp)
    }
    
    func upgrade() {
        let type = PlayerUpgrade.allCases.randomElement() ?? .shotSize
        let distribution = GKRandomDistribution(lowestValue: 50, highestValue: 100)
        let result = distribution.nextInt()
        let multiplier = Double(result)/100
        
        switch type {
        case .acceleration:
            data.upgradeAcceleration(multiplier: multiplier)
        case .maxSpeed:
            data.upgradeMaxSpeed(multiplier: multiplier)
        case .shotSpeed:
            data.upgradeShotSpeed(multiplier: multiplier)
        case .rateOfFire:
            data.upgradeShotCadence(multiplier: multiplier)
        case .shotSize:
            data.upgradeShotSize(multiplier: multiplier)
        case .maxHealth:
            data.upgradeMaxHealth(multiplier: multiplier)
        }
        
        hudDelegate?.updateUpgradeLabel(upgrades: [type: Float(multiplier)])
    }
}

extension PlayerLogicController: InputDelegate {
    
    func didChangeInputType(to inputType: InputType?) {
        print("changed input")
    }
    
    func updateMovement(vector: CGVector) {
        if data.velocity.magnitude < data.speedLimit {
            delegate?.apply(force: vector * data.moveMultiplier)
        } else {
            return
        }
    }
    
    func updateBodyAngle(direction angle: CGFloat) {
        let newAngle = angle - CGFloat.pi/2
        data.facingAngle = newAngle
        delegate?.rotateBody(to: newAngle)
    }
    
    func updateLegsAngle(direction angle: CGFloat) {
        let newAngle = angle - CGFloat.pi/2
        delegate?.rotateLegs(to: newAngle)
    }
    
    func shoot(_ currentTime: TimeInterval) {
        
        if timeLastShot == 0 {
            timeLastShot = currentTime + data.shotCadence
        }
        
        let timePast = currentTime - timeLastShot
        
        if timePast >= 0 && timePast < data.shotCadence {
            return
        }
        timeLastShot = currentTime
        
        let angle: CGFloat = self.data.facingAngle + CGFloat.pi/2
        
        let shootingMag = data.shootMagnitude
        let shootingForce = CGVector(angle: angle, magnitude: shootingMag)
        
        delegate?.shoot(force: shootingForce)
    }
    
}
