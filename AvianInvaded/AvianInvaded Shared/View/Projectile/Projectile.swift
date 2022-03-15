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
        self.physicsBody = .init(rectangleOf: size)
        
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.linearDamping = 0
        self.physicsBody?.mass = 0.1
        
        self.name = "projectilr"
        self.physicsBody?.collisionBitMask = .zero
        self.physicsBody?.contactTestBitMask = 1
        self.physicsBody?.categoryBitMask = .zero
        
        self.position = CGPoint(x: position.x, y: position.y)
        self.zPosition = 9
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension Projectile: Contactable {
    func contact(with node: SKNode) {
        if node.name == "wall" {
            removeFromParent()
        }
    }
    
}
