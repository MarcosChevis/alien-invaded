//
//  Math.swift
//  AvianInvaded
//
//  Created by Marcos Chevis on 04/03/22.
//

import Foundation
import CoreGraphics

extension CGVector {
    
    init(dx: Float, dy: Float) {
        self.init(dx: CGFloat(dx), dy: CGFloat(dy))
    }
    
    init(angle: CGFloat, magnitude: CGFloat) {
        let dx = cos(angle) * magnitude
        let dy = sin(angle) * magnitude
        
        self.init(dx: dx, dy: dy)
    }
    
    static func *(lhs: CGVector, rhs: CGFloat) -> CGVector {
        
        var vector: CGVector = .zero
        
        vector.dx = lhs.dx * rhs
        vector.dy = lhs.dy * rhs
        
        return vector
    }
    
//    init(angle: CGFloat) {
//        let vector = CGVector()
//
//
//    }
    
    static func +(lhs: CGVector, rhs: CGVector) -> CGVector {
        return CGVector(dx: lhs.dx + rhs.dx, dy: lhs.dy + rhs.dy)
    }
    
    var magnitude: CGFloat {
        if dx == CGFloat.zero && dy == CGFloat.zero {
            return CGFloat.zero
        }
        return sqrt((pow(dx, 2) + pow(dy, 2)))
    }
    
    var normalized: CGVector {
        let magnitude = self.magnitude
        guard magnitude > 0 else { return .zero }
        var vector = CGVector.zero
        vector.dx = self.dx / magnitude
        vector.dy = self.dy / magnitude
        
        return vector
    }
    
    var radAngle: CGFloat {
        if dx == 0 && dy == 0 {
            return 0
        }
        var resp = atan(dy/dx)
        
        if dx < 0 {
            resp = resp + (CGFloat.pi)
        }
        
        return resp
    }
    
   
}
