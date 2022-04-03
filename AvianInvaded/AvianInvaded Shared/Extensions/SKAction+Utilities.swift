//
//  SKAction+Utilities.swift
//  AvianInvaded
//
//  Created by Gabriel Ferreira de Carvalho on 18/03/22.
//

import SpriteKit

extension SKAction {
    
    static func pulseRed(duration: CGFloat = 0.26) -> SKAction {
        
        let pulseDuration = duration * 0.19
        let waitDuration = duration * 0.11
        
        return SKAction.sequence([
            SKAction.colorize(with: SKColor.red, colorBlendFactor: 1.0, duration: pulseDuration),
            SKAction.wait(forDuration: waitDuration),
            SKAction.colorize(withColorBlendFactor: 0.0, duration: pulseDuration),
            SKAction.colorize(with: SKColor.red, colorBlendFactor: 1.0, duration: pulseDuration),
            SKAction.wait(forDuration: waitDuration),
            SKAction.colorize(withColorBlendFactor: 0.0, duration: pulseDuration)
        ])
    }
}
