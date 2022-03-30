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
    private let attackNode: SKNode
    var projectileTexture: SKTexture
    weak var delegate: EnemyDelegate?
    
    lazy var idleBodyFrames: [SKTexture] = {
        SKTexture.loadCyclicalFromAtlas(named: "Flamingo_Attack-1")
    }()
    
    required init(spawnAt initialPosition: CGPoint, notificationCenter: NotificationCenter) {
        logicController = FlamingoLogicController()
        
        bodySprite = .init(imageNamed: "Flamingo_Attack-1")
        
        let projectileImage = UIImage(named: "Flamingo_Attack-1")
        self.projectileTexture = .init(image: projectileImage ?? .init())
        attackNode = SKNode()
        
        super.init()
        
        logicController.delegate = self
        self.colisionGroup = .enemy
        position = initialPosition
        zPosition = 10
        addChildren()
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
        bodySprite.addChild(attackNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createPhysicsBody(size: CGSize) {
        let texture = SKTexture(imageNamed: "Flamingo_Attack-1")
        texture.filteringMode = .nearest
        self.physicsBody = .init(texture: texture, size: size)
        self.physicsBody?.mass = logicController.mass
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.linearDamping = logicController.data.frictionMultiplier
        attackNode.position = .zero
        attackNode.physicsBody?.mass = 0
        attackNode.physicsBody = .init(circleOfRadius: 30)
        attackNode.physicsBody?.affectedByGravity = false
        attackNode.physicsBody?.allowsRotation = false
        attackNode.physicsBody?.isDynamic = true
       
        attackNode.physicsBody?.collisionBitMask = 0b0
        attackNode.physicsBody?.categoryBitMask = 0b0
        
        self.physicsBody?.collisionBitMask = ColisionGroup.getCollisionMask( self.colisionGroup)
        self.physicsBody?.contactTestBitMask = ColisionGroup.getContactMask( self.colisionGroup)
        self.physicsBody?.categoryBitMask = ColisionGroup.getCategotyMask( self.colisionGroup)
    }
    
    private func scale() {
        let size = self.bodySprite.scaleToScreen(scale: 0.17)
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
        case .portal:
            return
        }
    }
    
    
}
