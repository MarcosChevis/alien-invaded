//
//  PlayerSpriteNode.swift
//  AvianInvaded
//
//  Created by Marcos Chevis on 07/03/22.
//

import Foundation
import SpriteKit

class PlayerNode: SKNode, LifeCycleElement {

    private let logicController: PlayerLogicController = PlayerLogicController()
    private let bodySprite: SKSpriteNode
    var projectileTexture: SKTexture
    
    override init() {
        bodySprite = .init(imageNamed: "MainChar")
        bodySprite.setScale(logicController.scale)
        let projectileImage = UIImage(named: "Chicken")
        self.projectileTexture = .init(image: projectileImage ?? .init())
        
        super.init()
       
        let texture = SKTexture(imageNamed: "MainChar")
       self.physicsBody = .init(texture: texture, size: texture.size() * logicController.scale)
        self.physicsBody?.mass = logicController.mass
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.linearDamping = logicController.data.frictionMultiplier
        self.physicsBody?.collisionBitMask = 0
        self.addChildren()
    }
    
    func update(_ currentTime: TimeInterval) {
//        let friction = logicController.applyFriction(velocity: self.physicsBody?.velocity ?? .zero)
//        self.physicsBody?.applyForce(friction)
//        print(physicsBody!.velocity.magnitude)
    }
    
    private func addChildren() {
        addChild(bodySprite)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func rotate(by angle: CGFloat) {
        let action = SKAction.rotate(toAngle: angle, duration: .zero, shortestUnitArc: true)
        self.run(action)
    }
    
    func apply(force vector: CGVector) {
        guard
            let velocity = physicsBody?.velocity,
            let vector = logicController.move(by: vector, currentVelocity: velocity)
        else { return }
        self.physicsBody?.applyForce(vector)
    }
    
    func shoot(_ currentTime: TimeInterval) {
        guard let force = logicController.shoot(currentTime) else { return }
        
        
        let projectile = Projectile(texture: projectileTexture, size: CGSize(width: 10, height: 10), team: .player, position: self.position)
        
        self.parent?.addChild(projectile)
        
        projectile.physicsBody?.applyForce(force)
        print("piu")
    }
    
    
    
}

