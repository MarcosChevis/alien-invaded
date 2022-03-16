//
//  SKPhysicsBody+Scale.swift
//  AvianInvaded
//
//  Created by Marcos Chevis on 16/03/22.
//

import Foundation
import SpriteKit

extension SKPhysicsBody {
    func applyForceWithMultiplier(_ force: CGVector) {
        self.applyForce(force*GameConstants.forceMultiplier)
    }
}
