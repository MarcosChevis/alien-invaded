//
//  PlayerLogic.swift
//  AvianInvaded
//
//  Created by Marcos Chevis on 07/03/22.
//

import UIKit
import Foundation
import CoreGraphics

class PlayerLogicController {
    weak var delegate: PlayerLogicDelegate?
    var data: PlayerData
    
    var timeLastShot: TimeInterval
    
    var mass: CGFloat { data.mass }
    var scale: CGFloat { data.playerScale }
    
    init(data: PlayerData = .init()) {
        self.data = data
        self.timeLastShot = 0
    }
    
    func move(by vector: CGVector, currentVelocity: CGVector) -> CGVector? {
        if currentVelocity.magnitude < data.speedLimit {
            return vector * data.moveMultiplier
        } else {
            return nil
        }
        
    }
    
//    func applyFriction(velocity vector: CGVector) -> CGVector {        
//        return vector * -data.frictionMultiplier
//    }
    
    func shoot(_ currentTime: TimeInterval) -> CGVector? {
        
        if timeLastShot == 0 {
            timeLastShot = currentTime
        }
        
        let timePast = currentTime - timeLastShot
        print(timePast)
        
        if timePast < 0.5 {
            return nil
        }
        
        timeLastShot = currentTime
        let angle: CGFloat = data.facingAngle
        let shootingMag: CGFloat = 10
        
        let shootingForce = CGVector(angle: angle, magnitude: shootingMag)
        
        return shootingForce
    }
    
}
