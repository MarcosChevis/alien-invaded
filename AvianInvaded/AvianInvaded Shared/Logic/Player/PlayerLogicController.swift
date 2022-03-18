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
    var inputController: InputControllerProtocol
    var data: PlayerData
    
    var timeLastShot: TimeInterval
    
    var mass: CGFloat { data.mass }
    var scale: CGFloat { data.scale }
    
    init(data: PlayerData = .init(), inputController: InputControllerProtocol) {
        self.data = data
        self.inputController = inputController
        self.timeLastShot = 0
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
        if currentVelocity.magnitude < data.speedLimit*GameConstants.forceMultiplier {
            return vector * data.moveMultiplier
        } else {
            return nil
        }
        
    }
}

extension PlayerLogicController: InputDelegate {
    
    func didChangeInputType(to inputType: InputType?) {
        print("changed input")
    }
    
    func updateMovement(vector: CGVector) {
        if data.velocity.magnitude < data.speedLimit*GameConstants.forceMultiplier {
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
            timeLastShot = currentTime
        }
        
        let timePast = currentTime - timeLastShot
        
        if timePast >= 0 && timePast < 0.2 {
            return
        }
        timeLastShot = currentTime
        
        
        let angle: CGFloat = self.data.facingAngle + CGFloat.pi/2

        let shootingMag: CGFloat = 8000
        
        let shootingForce = CGVector(angle: angle, magnitude: shootingMag)
        
        delegate?.shoot(force: shootingForce)
    }
    
}

