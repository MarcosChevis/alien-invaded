//
//  Projectile.swift
//  AvianInvaded iOS
//
//  Created by Marcos Chevis on 10/03/22.
//

import Foundation
import SpriteKit

class Projectile: SKSpriteNode, LifeCycleElement {
        
    init(texture: SKTexture?, size: CGSize, team: Team, position: CGPoint) {
        super.init(texture: texture, color: SKColor.clear, size: size)
       
        self.setupPhysicsBody()
        self.setColisionGoup(team: team)
        self.position = CGPoint(x: position.x, y: position.y)
        self.zPosition = 9
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupPhysicsBody() {
        self.physicsBody = .init(rectangleOf: size)
        
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.linearDamping = 0
        self.physicsBody?.mass = 0.1
        
        self.physicsBody?.collisionBitMask = .zero
        self.physicsBody?.contactTestBitMask = 1
        self.physicsBody?.categoryBitMask = .zero
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

extension Projectile: Contactable {
    func contact(with colisionGroup: ColisionGroup) {
        if colisionGroup == .environment {
            removeFromParent()
        }
    }
    
}
