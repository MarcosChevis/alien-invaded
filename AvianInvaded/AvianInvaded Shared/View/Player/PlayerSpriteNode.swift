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
    
    lazy var idleBodyFrames: [SKTexture] =  {
        createTexture("Player_Idle")
    }()
    
    lazy var isIdle: Bool = true
    
    override init() {
        bodySprite = .init(imageNamed: "Pirate_Idle_0")
        bodySprite.setScale(logicController.scale)
        let projectileImage = UIImage(named: "Chicken")
        self.projectileTexture = .init(image: projectileImage ?? .init())
        
        super.init()
        
        self.name = "player"
        zPosition = 10
        self.addChildren()
        
        self.initializeIdle()
    }
    
    func startup() {
        scaleToScreen()
    }
    
    func update(_ currentTime: TimeInterval) {
        if !isIdle && self.physicsBody?.velocity == .zero {
            self.initializeIdle()
        } else if isIdle && self.physicsBody?.velocity != .zero {
            stopIdle()
        }
    }
    
    private func addChildren() {
        addChild(bodySprite)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func rotate(by angle: CGFloat) {
        logicController.data.facingAngle = angle
        let action = SKAction.rotate(toAngle: angle, duration: .zero, shortestUnitArc: true)
        self.run(action)
    }
    
    func apply(force vector: CGVector) {
        guard
            let velocity = physicsBody?.velocity,
            let vector = logicController.move(by: vector, currentVelocity: velocity)
        else { return }
        
        
        self.physicsBody?.applyForce(vector*GameConstants.forceMultiplier)
    }
    
    func shoot(_ currentTime: TimeInterval) {
        guard let shotData = logicController.shoot(currentTime, spriteCenter: self.bodySprite.position, spriteSize: self.bodySprite.size, node: self.bodySprite, scene: self.parent) else { return }
        
        
        let projectile = Projectile(texture: projectileTexture, size: CGSize(width: self.bodySprite.size.width*logicController.data.projectileSize, height: self.bodySprite.size.width*logicController.data.projectileSize), team: .player, position: shotData.from)
        
        self.parent?.addChild(projectile)
        
        projectile.physicsBody?.applyForceWithMultiplier(shotData.force)
    }
    
    private func initializeIdle() {
        let action = SKAction.repeatForever(SKAction.animate(with: idleBodyFrames,
                                                             timePerFrame: TimeInterval(0.3),
                                                             resize: false, restore: true))
        bodySprite.run(action)
        isIdle = true
    }
    
    private func stopIdle() {
        bodySprite.removeAllActions()
        isIdle = false
    }
    
    private func createTexture(_ name:String) -> [SKTexture] {
        let textureAtlas = SKTextureAtlas(named: name)
        var frames = [SKTexture]()
        for i in 0...textureAtlas.textureNames.count - 1 {
            frames.append(textureAtlas.textureNamed(textureAtlas.textureNames[i]))
        }
        return frames
    }
    
    private func createPhysicsBody(size: CGSize) {
        let texture = SKTexture(imageNamed: "Pirate_Idle_0")
        self.physicsBody = .init(texture: texture, size: size)
        self.physicsBody?.mass = logicController.mass
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.linearDamping = logicController.data.frictionMultiplier
        self.physicsBody?.collisionBitMask = 1
        self.physicsBody?.categoryBitMask = 0
    }
    
    private func scaleToScreen() {
        guard let sceneWidth = self.scene?.size.width else { return }
        guard let imageSize = self.bodySprite.texture?.size() else { return }
        
        let scale = logicController.scale
        
        let w = sceneWidth * scale
        let h = w * imageSize.height / imageSize.width
        
        let size = CGSize(width: w, height: h)
        
        
        createPhysicsBody(size: size)
        bodySprite.size = size
    }
    
}

