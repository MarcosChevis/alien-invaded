//
//  PlayerLogic.swift
//  AvianInvaded
//
//  Created by Marcos Chevis on 07/03/22.
//

import Foundation
import CoreGraphics

class PlayerLogic {
    weak var delegate: PlayerLogicDelegate?
    
    var facingAngle: CGFloat
    var position: CGPoint
    
    init() {
        facingAngle = 0
        self.position = CGPoint(x: 0, y: 0)
    }
    
    func move(by vector: CGVector, initialPosition: CGPoint) -> CGPoint {
        let v = vector * 5
        var point = initialPosition
        point.x += v.dx
        point.y += v.dy
        
        return point
    }
    

    
}
