//
//  EnemyLogicController.swift
//  AvianInvaded
//
//  Created by thais on 11/03/22.
//

import UIKit
import Foundation
import CoreGraphics

class EnemyLogicController{
    var data: EnemyData
    
    var timeLastShot: TimeInterval
    
    var mass: CGFloat { data.mass }
    var scale: CGFloat { data.enemyScale }
    
    init(data: EnemyData = .init()) {
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
    
    func attack(_ currentTime: TimeInterval) -> CGVector? {
        
        if timeLastShot == 0 {
            timeLastShot = currentTime
        }
        
        let timePast = currentTime - timeLastShot
        print(timePast)
        
        if timePast < 0.7 {
            return nil
        }
        
        timeLastShot = currentTime
        let angle: CGFloat = data.facingAngle
        let shootingMag: CGFloat = 10
        
        let shootingForce = CGVector(angle: angle, magnitude: shootingMag)
        
        return shootingForce
    }
}

