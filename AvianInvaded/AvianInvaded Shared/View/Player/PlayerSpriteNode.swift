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
    private let bodySprite: SKSpriteNode
    private let legsSprite: SKSpriteNode
    var projectileTexture: SKTexture
    
    lazy var idleBodyFrames: [SKTexture] = {
        createTexture("Player_Body_Idle")
    }()
    
    lazy var walkingLegsFrames: [SKTexture] = {
        createCyclicalTexture("Player_Legs_Walking")
    }()
    
    lazy var isIdle: Bool = true
    
    init(inputController: InputControllerProtocol) {
        
        self.logicController = PlayerLogicController(inputController: inputController)
        
        bodySprite = .init(imageNamed: "Player_Body_Idle_0")
        legsSprite = .init(imageNamed: "Player_Legs_Walking_0")
        
        let projectileImage = UIImage(named: "Chicken")
        self.projectileTexture = .init(image: projectileImage ?? .init())
        
        super.init()
        
        self.logicController.delegate = self
        self.colisionGroup = .player
        zPosition = 10
        self.addChildren()
        self.scale()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startup() {
        scale()
    }
    
    func update(_ currentTime: TimeInterval) {
        
        logicController.update(currentTime)
        
        guard let velocityMag = self.physicsBody?.velocity.magnitude else { return }
        let stoppingMag: CGFloat = 2
        
        if !isIdle && (velocityMag < stoppingMag) {
            self.isIdle = true
            self.initializeIdle()
            self.stopWalking()
        } else if isIdle && (velocityMag > stoppingMag) {
            self.isIdle = false
            self.initializeWalking()
            self.stopIdle()
        }
        
        guard let angle = self.physicsBody?.velocity.radAngle else { return }
        
        let action = SKAction.rotate(toAngle: logicController.data.facingAngle + angle + CGFloat.pi/2, duration: .zero, shortestUnitArc: true)
        legsSprite.run(action)
    }
    
    private func addChildren() {
        addChild(bodySprite)
        bodySprite.zPosition = 1
        addChild(legsSprite)
        legsSprite.zPosition = 0
    }
    
    
    
    private func initializeIdle() {
        let action = SKAction.repeatForever(SKAction.animate(with: idleBodyFrames,
                                                             timePerFrame: TimeInterval(0.3),
                                                             resize: false, restore: true))
        bodySprite.run(action)
    }
    
    private func stopIdle() {
        bodySprite.removeAllActions()
    }
    
    private func initializeWalking() {
        let action = SKAction.repeatForever(SKAction.animate(with: walkingLegsFrames,
                                                             timePerFrame: TimeInterval(0.1),
                                                             resize: false, restore: true))
        legsSprite.run(action)
    }
    
    private func stopWalking() {
        legsSprite.removeAllActions()
    }
    
    private func createTexture(_ name:String) -> [SKTexture] {
        let textureAtlas = SKTextureAtlas(named: name)
        var frames = [SKTexture]()
        for i in 0...textureAtlas.textureNames.count - 1 {
            frames.append(textureAtlas.textureNamed(textureAtlas.textureNames[i]))
        }
        frames = frames.sorted { text1, text2 in
            text1.description < text2.description
        }
        return frames
    }
    
    private func createCyclicalTexture(_ name: String) -> [SKTexture] {
        let frames = createTexture(name)
        var reversed = frames
        reversed.removeFirst()
        reversed = reversed.reversed()
        
        
        return frames + reversed
    }
    
    private func createPhysicsBody(size: CGSize) {
        let texture = SKTexture(imageNamed: "Player_Body_Idle_0")
        self.physicsBody = .init(texture: texture, size: size)
        self.physicsBody?.mass = logicController.mass
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.linearDamping = logicController.data.frictionMultiplier
        self.physicsBody?.collisionBitMask = 1
        self.physicsBody?.categoryBitMask = 0
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
    func rotate(by angle: CGFloat) {
        let action = SKAction.rotate(toAngle: angle, duration: .zero)
        self.run(action)
    }
    
    func apply(force vector: CGVector) {
        print(vector)
        self.physicsBody?.applyForce(vector*GameConstants.forceMultiplier)
    }
    
    func shoot(force: CGVector) {
        
        guard let scene = self.scene else { return }
        
        let x = bodySprite.size.width * 2
        let y = bodySprite.size.height * 3.2
        let projectilePositionInBodySpace: CGPoint = CGPoint(x: x, y: y)
        
        
        let projectilePositionInSceneSpace: CGPoint = self.convert(projectilePositionInBodySpace, to: scene)
        
        
        let w = self.bodySprite.size.width*logicController.data.projectileSize
        let h = self.bodySprite.size.width*logicController.data.projectileSize
        let size = CGSize(width: w, height: h)
        
        let projectile = ProjectileSpriteNode(texture: projectileTexture, size: size, team: .player, position: projectilePositionInSceneSpace)
        
        self.scene?.addChild(projectile)
        projectile.physicsBody?.applyForceWithMultiplier(force)
    }
}
