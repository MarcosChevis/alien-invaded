//
//  FlamingoSpriteNode.swift
//  AvianInvaded
//
//  Created by Thais Bras on 28/03/22.
//

import Foundation
import SpriteKit
import Combine

class FlamingoNode: SKNode, Enemy, EnemyLogicDelegate {
    
    private let logicController: FlamingoLogicController
    private let bodySprite: SKSpriteNode
    var projectileTexture: SKTexture
    
    lazy var idleBodyFrames: [SKTexture] = {
        createTexture("Flamingo_Attack-3")
    }()
    
    lazy var attackFrames: 
    
    required init(spawnAt initialPosition: CGPoint, notificationCenter: NotificationCenter) {
        logicController = FlamingoLogicController()
        
        bodySprite = .init(imageNamed: "Flamingo_Attack-3")
        
        let projectileImage = UIImage(named: "Flamingo_Attack-3")
        self.projectileTexture = .init(image: projectileImage ?? .init())
        
        super.init()
        
        logicController.delegate = self
        self.colisionGroup = .enemy
        position = initialPosition
        zPosition = 10
        addChild(bodySprite)
    }
    
    func startup() {
        scale()
    }
    
    func update(_ currentTime: TimeInterval) {
        logicController.followPoint(initialPoint: self.position)
        self.attack(currentTime)
    
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
    
    private func createPhysicsBody(size: CGSize) {
        let texture = SKTexture(imageNamed: "Flamingo_Attack-3")
        texture.filteringMode = .nearest
        self.physicsBody = .init(texture: texture, size: size)
        self.physicsBody?.mass = logicController.mass
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.linearDamping = logicController.data.frictionMultiplier
        
        self.physicsBody?.collisionBitMask = ColisionGroup.getCollisionMask( self.colisionGroup)
        self.physicsBody?.contactTestBitMask = ColisionGroup.getContactMask( self.colisionGroup)
        self.physicsBody?.categoryBitMask = ColisionGroup.getCategotyMask( self.colisionGroup)
    }
    
    private func scale() {
        let size = self.bodySprite.scaleToScreen(scale: logicController.data.scale)
        createPhysicsBody(size: size)
        bodySprite.size = size
    }
    
    func rotate(to angle: CGFloat) {
        let action = SKAction.rotate(toAngle: angle, duration: .zero, shortestUnitArc: true)
        logicController.data.facingAngle = angle
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
        guard let force = logicController.decideAtack(currentTime: currentTime, position: self.position) else { return }
        
        guard let scene = self.scene else { return }
        
        let x: CGFloat = 0
        let y: CGFloat = -bodySprite.size.height*0.45
        
        let projectilePositionInBodySpace: CGPoint = CGPoint(x: x, y: y)
        let projectilePositionInSceneSpace: CGPoint = bodySprite.convert(projectilePositionInBodySpace, to: scene)
        
        let w = self.bodySprite.size.width*logicController.data.projectileSize
        
        let h = self.bodySprite.size.width*logicController.data.projectileSize
        
        let size = CGSize(width: w, height: h)
        
        let projectile = ProjectileSpriteNode(texture: projectileTexture, size: size, team:.avian, position: projectilePositionInSceneSpace)
        
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
            //print("Player")
            return
        case .enemy:
            return
        case .playerProjectile:
            takeDamage()
            //print("Projectile Hit")
        case .enemyProjectile:
            return
        case .neutralProjectile:
            return
        }
    }
    
    
}