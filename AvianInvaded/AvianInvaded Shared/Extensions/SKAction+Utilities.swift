//
//  SKAction+Utilities.swift
//  AvianInvaded
//
//  Created by Gabriel Ferreira de Carvalho on 18/03/22.
//

import SpriteKit

extension SKAction {
    
    static func pulseRed() -> SKAction {
        SKAction.sequence([
            SKAction.colorize(with: SKColor.red, colorBlendFactor: 1.0, duration: 0.05),
            SKAction.wait(forDuration: 0.03),
            SKAction.colorize(withColorBlendFactor: 0.0, duration: 0.05),
            SKAction.colorize(with: SKColor.red, colorBlendFactor: 1.0, duration: 0.05),
            SKAction.wait(forDuration: 0.03),
            SKAction.colorize(withColorBlendFactor: 0.0, duration: 0.05)
        ])
    }
}
