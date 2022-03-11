//
//  Projectile.swift
//  AvianInvaded iOS
//
//  Created by Marcos Chevis on 10/03/22.
//

import Foundation
import SpriteKit

class Projectile: SKSpriteNode {
    
    var team: Team
    
    init(texture: SKTexture?, size: CGSize, team: Team, position: CGPoint) {
        self.team = team
        super.init(texture: texture, color: SKColor.clear, size: size)
        self.physicsBody = .init(rectangleOf: CGSize(width: 10, height: 10))
        self.physicsBody?.collisionBitMask = .zero
        self.physicsBody?.categoryBitMask = .zero
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.linearDamping = 0
        
        self.position = CGPoint(x: position.x, y: position.y)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
