//
//  EnemySpriteNode.swift
//  AvianInvaded
//
//  Created by thais on 11/03/22.
//

import Foundation
import SpriteKit

class ChickenNode: SKNode, Enemy {
    
    private let logicController: ChickenLogicController = ChickenLogicController()
    private let bodySprite: SKSpriteNode
    var projectileTexture: SKTexture
    
    required init(spawnAt initialPosition: CGPoint) {
        bodySprite = .init(imageNamed: "Chicken")
        
        let projectileImage = UIImage(named: "Chicken")
        self.projectileTexture = .init(image: projectileImage ?? .init())
        
        super.init()
        self.colisionGroup = .enemy
        position = initialPosition
        zPosition = 9
        addChild(bodySprite)
    }
    
    func startup() {
        scale()
    }
    
    func update(_ currentTime: TimeInterval) {
        
    }
    
    func tearDown() {
        removeFromParent()
    }
    
    private func addChildren() {
        addChild(bodySprite)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func move(path: [CGPoint], tileSize: CGFloat) {
        removeAllActions()
        
        let moveAction = path.map { point in
            SKAction.move(to: CGPoint(x: point.x * tileSize, y: point.y * tileSize), duration: 0.2)
        }
        
        self.run(SKAction.sequence(moveAction))
    }
    
    private func createPhysicsBody(size: CGSize) {
        let texture = SKTexture(imageNamed: "Chicken")
        self.physicsBody = .init(texture: texture, size: size)
        self.physicsBody?.mass = logicController.mass
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.linearDamping = logicController.data.frictionMultiplier
        self.physicsBody?.collisionBitMask = 1
        self.physicsBody?.categoryBitMask = 1
    }
    
    private func scale() {
        let size = self.bodySprite.scaleToScreen(scale: logicController.data.scale)
        createPhysicsBody(size: size)
        bodySprite.size = size
    }
    
    func rotate(by angle: CGFloat) {
        let action = SKAction.rotate(toAngle: angle, duration: .zero, shortestUnitArc: true)
        self.run(action)
    }
    
    func apply(force vector: CGVector){
        guard
            let velocity = physicsBody?.velocity,
            let vector = logicController.move(by: vector, currentVelocity: velocity)
        else { return }
        self.physicsBody?.applyForce(vector)
    }
    
    func attack(_ currentTime: TimeInterval) {
        guard let force = logicController.attack(currentTime) else { return }
        
        let projectile = ProjectileSpriteNode(texture: projectileTexture, size: CGSize(width: 10, height: 10), team: .player, position: self.position)
        
        self.scene?.addChild(projectile)
        
        projectile.physicsBody?.applyForce(force)
    }
    
    private func takeDamage() {
        pulseRed()
        let isDead = logicController.receiveDamage()
        
        if isDead {
            tearDown()
        }
    }
    
    private func pulseRed() {
        bodySprite.removeAllActions()
        let pulseRed = SKAction.pulseRed()
        bodySprite.run(pulseRed)
    }
    
    func contact(with colisionGroup: ColisionGroup) {
        switch colisionGroup {
        case .environment:
            return
        case .player:
            print("Player")
        case .enemy:
            return
        case .playerProjectile:
            takeDamage()
            print("Projectile Hit")
        case .enemyProjectile:
            return
        case .neutralProjectile:
            return
        }
    }
}
