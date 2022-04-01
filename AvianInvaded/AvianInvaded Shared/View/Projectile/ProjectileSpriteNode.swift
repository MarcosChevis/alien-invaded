//
//  Projectile.swift
//  AvianInvaded iOS
//
//  Created by Marcos Chevis on 10/03/22.
//

import Foundation
import SpriteKit

class ProjectileSpriteNode: SKSpriteNode, LifeCycleElement {
    
    var damage: CGFloat?
    
    init(texture: SKTexture?, size: CGSize, team: Team, position: CGPoint, damage: CGFloat) {
        
        self.damage = damage
        super.init(texture: texture, color: SKColor.clear, size: size)
        
        self.setColisionGoup(team: team)
        self.setupPhysicsBody()
        self.position = CGPoint(x: position.x, y: position.y)
        self.zPosition = 2
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupPhysicsBody() {
        
        self.physicsBody = .init(circleOfRadius: size.height/2)
        
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.linearDamping = 0
        self.physicsBody?.mass = 0.1
        
        self.physicsBody?.collisionBitMask = ColisionGroup.getCollisionMask( self.colisionGroup)
        self.physicsBody?.contactTestBitMask = ColisionGroup.getContactMask( self.colisionGroup)
        self.physicsBody?.categoryBitMask = ColisionGroup.getCategotyMask( self.colisionGroup)
        
        self.lightingBitMask = ColisionGroup.getLightMask(colisionGroup)
    }
    
    private func setColisionGoup(team: Team) {
        switch team {
        case .none:
            self.colisionGroup = .neutralProjectile
        case .player:
            self.colisionGroup = .playerProjectile
        case .avian:
            self.colisionGroup = .enemyProjectile
        }
    }
    
    func update(_ currentTime: TimeInterval) {
        guard let angle = self.physicsBody?.velocity.radAngle else { return }
        let action = SKAction.rotate(toAngle: angle - CGFloat.pi/2, duration: 0)
        self.run(action)
    }
    
}

extension ProjectileSpriteNode: Contactable {
    func contact(with colisionGroup: ColisionGroup, damage: CGFloat?) {
        if colisionGroup == .environment
        || self.colisionGroup == .enemyProjectile && colisionGroup == .player
        || self.colisionGroup == .playerProjectile && colisionGroup == .enemy {
            removeFromParent()
        }
    }
}
