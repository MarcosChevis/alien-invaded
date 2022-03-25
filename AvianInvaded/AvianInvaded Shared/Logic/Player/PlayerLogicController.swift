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

class PlayerLogicController: LifeCycleElement {
    
    weak var delegate: PlayerLogicDelegate?
    weak var hudDelegate: PlayerHudDelegate?
    
    var inputController: InputControllerProtocol
    var data: PlayerData
    
    var timeLastShot: TimeInterval
    
    var mass: CGFloat { data.mass }
    var scale: CGFloat { data.scale }
    
    private let notificationCenter: NotificationCenter
    
    init(data: PlayerData = .init(), inputController: InputControllerProtocol, notificationCenter: NotificationCenter) {
        self.data = data
        self.inputController = inputController
        self.timeLastShot = 0
        self.notificationCenter = notificationCenter
        self.inputController.delegate = self
    }
    
    func update(_ currentTime: TimeInterval) {
        inputController.update(currentTime)
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
    
    var a = 1.0
    func takeDamage() {
        a -= 0.01
        hudDelegate?.updateHealth(a)
    }
    
    var b = 0.0
    func gainXp() {
        b += 0.1
        hudDelegate?.updateExperience(b)
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
    #warning("UPDATE PLAYER DATA")
    
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

