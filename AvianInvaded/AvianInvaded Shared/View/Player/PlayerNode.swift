//
//  PlayerSpriteNode.swift
//  AvianInvaded
//
//  Created by Marcos Chevis on 07/03/22.
//

import Foundation
import SpriteKit

class PlayerNode: SKNode, LifeCycleElement {
    
    private let logicController: PlayerLogicController
    private let bodyNode: PlayerBodyNode
    private let bodySprite: SKSpriteNode
    private let legsSprite: SKSpriteNode
    private var projectileTexture: SKTexture
    private var lightNode: SKLightNode?
    
    lazy var idleBodyFrames: [SKTexture] = {
        SKTexture.loadFromAtlas(named: "Player_Body_Idle")
    }()
    
    lazy var walkingLegsFrames: [SKTexture] = {
        SKTexture.loadCyclicalFromAtlas(named: "Player_Legs_Walking")
    }()
    
    lazy var isIdle: Bool = true
    
    lazy var shootingFrames: [SKTexture] = {
        SKTexture.loadFromAtlas(named: "Player_Shoot") + [idleBodyFrames[0]]
    }()
    
    init(inputController: InputControllerProtocol,
         hudDelegate: PlayerHudDelegate,
         playerStateDelegate: PlayerStateDelegate) {
        
        self.logicController = PlayerLogicController(inputController: inputController,
                                                     notificationCenter: .default)
        logicController.playerStateDelegate = playerStateDelegate
        logicController.hudDelegate = hudDelegate
        
        bodyNode = .init()
        
        bodySprite = .init(imageNamed: "Player_Body_Idle_0")
        legsSprite = .init(imageNamed: "Player_Legs_Walking-5")
        
        let projectileImage = UIImage(named: "Player_Projectile")
        self.projectileTexture = .init(image: projectileImage ?? .init())
        
        super.init()
        
        bodyNode.contactDelegate = self
        self.logicController.delegate = self
        self.colisionGroup = .player
        zPosition = 2
        self.addChildren()
        self.initializeIdle()
        setupLighting()

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startup() {
        scale()
    }
    
    func setupLighting() {
        if let current = self.lightNode {
            removeChildren(in: [current])
            self.lightNode = nil
        }
        
        let lightNode = SKLightNode()
        lightNode.ambientColor = .init(white: 0.15, alpha: 1)
        lightNode.lightColor = .init(white: 1, alpha: 0.7)
        lightNode.falloff = 0.7
        lightNode.categoryBitMask = ColisionGroup.getCategotyMask(.light)
        lightNode.zPosition = 3
        addChild(lightNode)
        self.lightNode = lightNode
    }
    
    func update(_ currentTime: TimeInterval) {
        
        logicController.update(currentTime)
        
        testMeleeAttacks()

        guard let velocityMag = self.physicsBody?.velocity.magnitude else { return }
        let stoppingMag: CGFloat = 50
        
        if !isIdle && (velocityMag < stoppingMag) {
            self.isIdle = true
            self.initializeIdle()
            self.stopWalking()
        } else if isIdle && (velocityMag > stoppingMag) {
            self.isIdle = false
            self.initializeWalking()
            self.stopIdle()
        }
    }
    
    private func testMeleeAttacks() {
        if let attackDamage = bodyNode.physicsBody?.allContactedBodies()
            .compactMap({ ($0.node?.colisionGroup, ($0.node as? Contactable)?.damage) })
            .first(where: { $0.0 == .enemyMeleeAttack })?.1 {
            self.logicController.loseHealth(attackDamage)
        }
    }
    
    func didSimulatePhysics() {
        logicController.sendPlayerDidMove(newPosition: self.position)
    }
    
    func reset() {
        let rotation = SKAction.rotate(toAngle: 0, duration: 0)
        bodyNode.run(rotation)
        logicController.reset()
    }
    
    func enemyWasKilled() {
        logicController.gainXp()
    }
    
    private func addChildren() {
        self.addChild(bodyNode)
        bodyNode.addChild(bodySprite)
        bodySprite.zPosition = 2
        addChild(legsSprite)
        legsSprite.zPosition = 1
    }
    
    private func initializeIdle() {
        let timePerFrame = Double(logicController.data.idleTime)/Double(idleBodyFrames.count)
        
        let action = SKAction.repeatForever(SKAction.animate(with: idleBodyFrames,
                                                             timePerFrame: timePerFrame,
                                                             resize: false, restore: false))
        bodySprite.run(action, withKey: "Idle_Animation")
    }
    
    private func stopIdle() {
        bodySprite.removeAction(forKey: "Idle_Animation")
    }
    
    private func initializeWalking() {
        let timePerFrame = Double(logicController.data.walkingTime)/Double(walkingLegsFrames.count)
        let action = SKAction.repeatForever(SKAction.animate(with: walkingLegsFrames,
                                                             timePerFrame: timePerFrame,
                                                             resize: false, restore: false))
        legsSprite.run(action, withKey: "Walking_Animation")
    }
    
    private func stopWalking() {
        legsSprite.removeAction(forKey: "Walking_Animation")
    }
    
    private func initializeShooting() {
        let timePerFrame = Double(logicController.data.shotCadence)/Double(shootingFrames.count)
        let action = SKAction.animate(with: shootingFrames,
                                      timePerFrame: timePerFrame,
                                      resize: false,
                                      restore: false)
        self.bodySprite.run(action)
    }
    private func createPhysicsBody(size: CGSize) {
        
        self.physicsBody = .init()
        self.physicsBody?.mass = logicController.mass
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.linearDamping = logicController.data.frictionMultiplier
        
        // Body - Hitbox
        self.bodyNode.colisionGroup = .player
        let texture = SKTexture(imageNamed: "Player_Body_Idle_0")
        let body = SKPhysicsBody.init(texture: texture, size: size)
        self.bodyNode.physicsBody = body
        self.bodyNode.physicsBody?.affectedByGravity = false
        self.bodyNode.physicsBody?.allowsRotation = false
        self.bodyNode.physicsBody?.linearDamping = 0
        self.bodyNode.physicsBody?.friction = 0
        
        self.bodyNode.physicsBody?.collisionBitMask = ColisionGroup.getCollisionMask(self.colisionGroup)
        self.bodyNode.physicsBody?.contactTestBitMask = ColisionGroup.getContactMask(self.colisionGroup)
        self.bodyNode.physicsBody?.categoryBitMask = ColisionGroup.getCategotyMask(self.colisionGroup)
        
        self.bodySprite.lightingBitMask = ColisionGroup.getLightMask(self.colisionGroup)

        self.legsSprite.lightingBitMask = ColisionGroup.getLightMask(self.colisionGroup)

        guard let physicsBody = self.physicsBody,
              let scene = self.scene else { return }
        let pinMotherBody = SKPhysicsJointPin.joint(withBodyA: physicsBody,
                                                    bodyB: body,
                                                    anchor: convert(self.bodyNode.position, to: scene))

        scene.physicsWorld.add(pinMotherBody)
    }
    
    private func scale() {
        var size = self.bodySprite.scaleToScreen(scale: logicController.scale)
        createPhysicsBody(size: size)
        bodySprite.size = size
        
        self.legsSprite.position = CGPoint(x: self.legsSprite.position.x , y: -size.height*0.20)
        
        size = self.legsSprite.scaleToScreen(scale: logicController.scale/2)
        legsSprite.size = size
    }
}

extension PlayerNode: PlayerLogicDelegate {
    func takeDamage(duration: CGFloat) {
        self.bodySprite.run(SKAction.pulseRed(duration: duration))
    }
    
    func rotateBody(to angle: CGFloat) {
        let action = SKAction.rotate(toAngle: angle, duration: .zero)
        
        let magnitude = self.legsSprite.size.height*0.20
        
        let vector = CGVector(angle: angle - CGFloat.pi/2, magnitude: magnitude)
        
        self.legsSprite.position = CGPoint(x: vector.dx, y: vector.dy)
        
        self.bodyNode.run(action)
    }
    
    func rotateLegs(to angle: CGFloat) {
        let action = SKAction.rotate(toAngle: angle, duration: .zero)
        self.legsSprite.run(action)
    }
    
    func apply(force vector: CGVector) {
        self.physicsBody?.applyForce(vector)
    }
    
    func shoot(force: CGVector) {
        
        guard let scene = self.scene else { return }
        self.initializeShooting()
        
        let x = bodySprite.size.width * 0.3
        let y = bodySprite.size.height * 0.35
        
        let projectilePositionInBodySpace: CGPoint = CGPoint(x: x, y: y)
        let projectilePositionInSceneSpace: CGPoint = bodySprite.convert(projectilePositionInBodySpace,
                                                                         to: scene)
        
        let w = self.bodySprite.size.width*logicController.data.projectileSize
        let h = self.bodySprite.size.width*logicController.data.projectileSize
        
        let size = CGSize(width: w, height: h)
        
        let projectile = ProjectileSpriteNode(texture: projectileTexture,
                                              size: size,
                                              team: .player,
                                              position: projectilePositionInSceneSpace,
                                              damage: logicController.data.projectileDamage)
        
        self.scene?.addChild(projectile)
        projectile.physicsBody?.applyForce(force)
    }
}

extension PlayerNode: Contactable {
    
    func contact(with colisionGroup: ColisionGroup, damage: CGFloat?) {
        switch colisionGroup {
        case .environment:
            return
        case .player:
            return
        case .enemy:
            return
        case .playerProjectile:
            return
        case .enemyProjectile:
            logicController.loseHealth(damage ?? 0)
        case .neutralProjectile:
            return
        case .portal:
            return
        case .light:
            return
        case .enemyMeleeAttack:
            return
        }
    }

}
