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

class PlayerLogicController {
    weak var delegate: PlayerLogicDelegate?
    var data: PlayerData
    
    var timeLastShot: TimeInterval
    
    var mass: CGFloat { data.mass }
    var scale: CGFloat { data.scale }
    
    init(data: PlayerData = .init()) {
        self.data = data
        self.timeLastShot = 0
    }
    
    func move(by vector: CGVector, currentVelocity: CGVector) -> CGVector? {
        if currentVelocity.magnitude < data.speedLimit*GameConstants.forceMultiplier {
            return vector * data.moveMultiplier
        } else {
            return nil
        }
        
    }
    
    func shoot(_ currentTime: TimeInterval, spriteCenter: CGPoint, spriteSize: CGSize, node: SKNode, scene: SKNode?) -> (from: CGPoint, force: CGVector)? {
        
        if timeLastShot == 0 {
            timeLastShot = currentTime
        }
        
        guard let scene = scene else {
            return nil
        }

        
        let x = spriteSize.width * 2
        let y = spriteSize.height * 3.2
        
        //print(x, y)
        
        let projectilePositionInBodySpace: CGPoint = CGPoint(x: x, y: y)
        let projectilePositionInSceneSpace: CGPoint = node.convert(projectilePositionInBodySpace, to: scene)
        
        let timePast = currentTime - timeLastShot
        //print(timePast)
        
        if timePast < 0.2 {
            return nil
        }
        
        timeLastShot = currentTime
        let angle: CGFloat = data.facingAngle + CGFloat.pi/2
        
        let shootingMag: CGFloat = 8000
        
        let shootingForce = CGVector(angle: angle, magnitude: shootingMag)
        
        return (projectilePositionInSceneSpace, shootingForce)
    }
    
}
//
//extension PlayerLogicController: InputDelegate {
//    func didChangeInputType(to inputType: InputType?) {
//        guard let inputType = inputType else {
//            print("no input connected")
//            return
//        }
//        switch inputType {
//        case .controller:
//            print("controller connected")
//        case .keyboard:
//            print("keyboard connected")
//        }
//        
//    }
//    
//    func updateMovement(vector: CGVector) {
//        if data.velocity.magnitude < data.speedLimit*GameConstants.forceMultiplier {
//            return vector * data.moveMultiplier
//        } else {
//            return nil
//        }
//    }
//    
//    func updateAngle(direction angle: CGFloat) {
//        gameLogicDelegate?.rotatePlayerTo(angle: angle - (CGFloat.pi/2))
//    }
//    
//    func shoot(_ currentTime: TimeInterval) {
//        gameLogicDelegate?.shoot(currentTime)
//    }
//    
//    
//}
