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
       
        
        self.addChildren()
    }
    
    func startup() {
        scaleToScreen()
    }
    
    func update(_ currentTime: TimeInterval) {

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
        logicController.data.facingAngle = angle
    }
    
    func apply(force vector: CGVector) {
        guard
            let velocity = physicsBody?.velocity,
            let vector = logicController.move(by: vector, currentVelocity: velocity)
        else { return }
        self.physicsBody?.applyForce(vector)
    }
    
    func shoot(_ currentTime: TimeInterval) {
        guard let shotData = logicController.shoot(currentTime, spriteCenter: self.bodySprite.position, spriteSize: self.bodySprite.size, node: self.bodySprite, scene: self.parent) else { return }
        
        
        let projectile = Projectile(texture: projectileTexture, size: CGSize(width: self.bodySprite.size.width/10, height: self.bodySprite.size.width/10), team: .player, position: shotData.from)
        
        self.parent?.addChild(projectile)
        
        projectile.physicsBody?.applyForce(shotData.force)
        print("piu")
    }
    
    private func createPhysicsBody(size: CGSize) {
        let texture = SKTexture(imageNamed: "MainChar")
        self.physicsBody = .init(texture: texture, size: size)
        self.physicsBody?.mass = logicController.mass
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.linearDamping = logicController.data.frictionMultiplier
        self.physicsBody?.collisionBitMask = 0
    }
    
    private func scaleToScreen() {
        guard let sceneWidth = self.scene?.size.width else { return }
        guard let imageSize = self.bodySprite.texture?.size() else { return }
        
        let scale = logicController.scale
        
        let w = sceneWidth * scale
        let h = w * imageSize.height / imageSize.width
        
        
        
        createPhysicsBody(size: CGSize(width: w, height: h))
        bodySprite.size = CGSize(width: w, height: h)
    }
    
}

