//
//  EnemyNode.swift
//  AvianInvaded
//
//  Created by Marcos Chevis on 31/03/22.
//

import Foundation
import SpriteKit

protocol EnemyNodeProtocol: Enemy, EnemyLogicDelegate {
    var bodySprite: SKSpriteNode { get }
    
    func createPhysicsBody(size: CGSize,
                           imageName: String,
                           colisionGroup: ColisionGroup,
                           mass: CGFloat,
                           frictionMultiplier: CGFloat) -> SKPhysicsBody
    
    func attack(_ currentTime: TimeInterval)
    
    func takeDamage(_ amount: CGFloat, receiveDamage: (CGFloat) -> Bool)
    
    func pulseRed()
}

extension EnemyNodeProtocol {
    func createPhysicsBody(size: CGSize,
                           imageName: String,
                           colisionGroup: ColisionGroup,
                           mass: CGFloat,
                           frictionMultiplier: CGFloat) -> SKPhysicsBody {
        let texture = SKTexture(imageNamed: imageName)
        texture.filteringMode = .nearest

        let physicsBody: SKPhysicsBody = .init(texture: texture, size: size)
        physicsBody.mass = mass
        physicsBody.affectedByGravity = false
        physicsBody.allowsRotation = false
        physicsBody.linearDamping = frictionMultiplier

        physicsBody.collisionBitMask = ColisionGroup.getCollisionMask(colisionGroup)
        physicsBody.contactTestBitMask = ColisionGroup.getContactMask(colisionGroup)
        physicsBody.categoryBitMask = ColisionGroup.getCategotyMask(colisionGroup)

        bodySprite.lightingBitMask = ColisionGroup.getLightMask(colisionGroup)

        return physicsBody
    }

    func rotate(to angle: CGFloat) {
        let action = SKAction.rotate(toAngle: angle, duration: .zero, shortestUnitArc: true)
        self.run(action)
    }

    func apply(force vector: CGVector,
               calculateForce: (CGVector, CGVector) -> CGVector?) {
        guard
            let velocity = self.physicsBody?.velocity,
            let vector = calculateForce(vector, velocity)
        else { return }
        self.physicsBody?.applyForce(vector)
    }

    func takeDamage(_ amount: CGFloat, receiveDamage: (CGFloat) -> Bool) {
        pulseRed()
        let isDead = receiveDamage(amount)

        if isDead {
            tearDown()
        }
    }

    func pulseRed() {
        bodySprite.removeAllActions()
        let pulseRed = SKAction.pulseRed()
        bodySprite.run(pulseRed)
    }

}
