//
//  FlamingoSpriteNode.swift
//  AvianInvaded
//
//  Created by Marcos Chevis on 31/03/22.
//

import Foundation
import SpriteKit

class FlamingoNode: SKNode, EnemyNodeProtocol {
    
    private let logicController: FlamingoLogicController
    let bodySprite: SKSpriteNode
    weak var delegate: EnemyDelegate?
    var attackIsActive: Bool
    
    lazy var attackBodyFrames: [SKTexture] = {
        createCyclicalTexture("Flamingo_Body_Attack")
    }()

    required init(spawnAt initialPosition: CGPoint,
                  notificationCenter: NotificationCenter,
                  initialData: EnemyData) {
        logicController = FlamingoLogicController(data: initialData,
                                                  notificationCenter: notificationCenter)

        let tex = SKTexture(imageNamed: "Flamingo_Body_Attack-1")
        tex.filteringMode = .nearest
        bodySprite = .init(texture: tex)
        self.attackIsActive = false

        super.init()
        logicController.delegate = self
        self.colisionGroup = .enemy
        position = initialPosition
        zPosition = 2
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
        delegate?.enemyWasDefeatead()
        removeFromParent()
    }

    private func addChildren() {
        addChild(bodySprite)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func scale() {
        let size = self.bodySprite.scaleToScreen(scale: logicController.data.scale)
        self.physicsBody = createPhysicsBody(size: size,
                                             imageName: "Flamingo_Hitbox",
                                             colisionGroup: self.colisionGroup ?? .enemy,
                                             mass: logicController.data.mass,
                                             frictionMultiplier: logicController.data.frictionMultiplier)
        bodySprite.size = size
        
    }

    func attack(_ currentTime: TimeInterval) {
        
        guard let force = logicController.decideAtack(currentTime: currentTime,
                                                      position: self.position) else { return }
        
        let action = SKAction.animate(with: self.attackBodyFrames,
                                      timePerFrame: 0.1,
                                      resize: false,
                                      restore: true)

        if !attackIsActive {
            attackIsActive = true
            bodySprite.run(action) {
                self.attackIsActive = false
            }
        }
    }

    func contact(with colisionGroup: ColisionGroup, damage: CGFloat?) {
        if colisionGroup == .playerProjectile {
            pulseRed()
            let isDead = logicController.receiveDamage(damage ?? 0)
            
            if isDead { tearDown() }
        }
    }
}
