//
//  CGPoint+Math.swift
//  AvianInvaded
//
//  Created by Gabriel Ferreira de Carvalho on 24/03/22.
//

import CoreGraphics

extension CGPoint {
    static func *(lhs: CGPoint, rhs: CGFloat) -> CGPoint {
        var p = CGPoint(x: lhs.x, y: lhs.y)
        p.x *= rhs
        p.y *= rhs
        return p
    }
    
    static func +=(lhs: inout CGPoint, rhs: CGPoint) {
        lhs.y += rhs.y
        lhs.x += rhs.x
    }
    
    var intX: Int {
        return Int(x)
    }
    
    var intY: Int {
        return Int(y)
    }
}
