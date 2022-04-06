//
//  RoomDirection.swift
//  AvianInvaded
//
//  Created by Gabriel Ferreira de Carvalho on 22/03/22.
//

import Foundation
import CoreGraphics

enum RoomDirection: String, CaseIterable, Codable {
    case top, left, right, bottom
    
    var point: CGPoint {
        switch self {
        case .top:
            return CGPoint(x: 0, y: -1)
        case .bottom:
            return CGPoint(x: 0, y: 1)
        case .left:
            return CGPoint(x: -1, y: 0)
        case .right:
            return CGPoint(x: 1, y: 0)
        }
    }
    
    var angle: Double {
        switch self {
        case .top:
            return 0
        case .left:
            return .pi/2
        case .right:
            return .pi * 1.5
        case .bottom:
            return .pi
        }
    }
    
    static func getRandomPoint() -> CGPoint {
        return (RoomDirection.allCases.randomElement() ?? .top).point
    }
    
    static prefix func ! (op: RoomDirection) -> RoomDirection {
        switch op {
        case top:
            return self.bottom
        case .bottom:
            return self.top
        case .left:
            return self.right
        case .right:
            return self.left
        }
    }
}
