//
//  PlayerLogic.swift
//  AvianInvaded
//
//  Created by Marcos Chevis on 07/03/22.
//

import Foundation
import CoreGraphics

class PlayerLogicController {
    weak var delegate: PlayerLogicDelegate?
    private var data: PlayerData
    
    var mass: CGFloat { data.mass }
    var scale: CGFloat { data.playerScale }
    
    init(data: PlayerData = .init()) {
        self.data = data
    }
    
    func move(by vector: CGVector, currentVelocity: CGVector) -> CGVector? {
        if currentVelocity.magnitude < data.speedLimit {
            return vector * data.moveMultiplier
        } else {
            return nil
        }
        
    }
    
    func applyFriction(velocity vector: CGVector) -> CGVector {        
        return vector * -data.frictionMultiplier
    }
    

    
}
