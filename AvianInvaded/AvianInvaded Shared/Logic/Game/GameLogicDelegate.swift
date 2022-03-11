//
//  GameLogicDelegate.swift
//  AvianInvaded
//
//  Created by Marcos Chevis on 07/03/22.
//

import Foundation
import SpriteKit

protocol GameLogicDelegate: AnyObject {
    
    func movePlayer(with vector: CGVector)
    func rotatePlayerTo(angle: CGFloat)
    func shoot(_ currentTime: TimeInterval)
}
