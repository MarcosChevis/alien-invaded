//
//  EnemySpriteNode.swift
//  AvianInvaded
//
//  Created by thais on 11/03/22.
//

import Foundation
import SpriteKit
import Combine

class ChickenNode: SKNode, EnemyNodeProtocol {
    
    private let logicController: ChickenLogicController
    let bodySprite: SKSpriteNode
    var projectileTexture: SKTexture
    weak var delegate: EnemyDelegate?

    required init(spawnAt initialPosition: CGPoint,
                  notificationCenter: NotificationCenter,
                  initialData: EnemyData) {
        logicController = ChickenLogicController(data: initialData,
                                                 notificationCenter: notificationCenter)

        bodySprite = .init(imageNamed: "Chicken")

        let projectileImage = UIImage(named: "Chicken_Egg")
        self.projectileTexture = .init(image: projectileImage ?? .init())
        self.projectileTexture.filteringMode = .nearest
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
                                             imageName: "Chicken",
                                             colisionGroup: self.colisionGroup ?? .enemy,
                                             mass: logicController.data.mass,
                                             frictionMultiplier: logicController.data.frictionMultiplier)
        bodySprite.size = size
        
    }

    func attack(_ currentTime: TimeInterval) {
        guard let force = logicController.decideAtack(currentTime: currentTime,
                                                      position: self.position)
        else {
            return
        }

        guard let scene = self.scene else { return }

        let x: CGFloat = 0
        let y: CGFloat = -bodySprite.size.height*0.45

        let projectilePositionInBodySpace: CGPoint = CGPoint(x: x, y: y)
        let projectilePositionInSceneSpace: CGPoint = bodySprite.convert(projectilePositionInBodySpace,
                                                                         to: scene)

        let w = self.bodySprite.size.width*logicController.data.projectileSize

        let h = self.bodySprite.size.width*logicController.data.projectileSize

        let size = CGSize(width: w, height: h)

        let projectile = ProjectileSpriteNode(texture: projectileTexture,
                                              size: size,
                                              team: .avian,
                                              position: projectilePositionInSceneSpace,
                                              damage: logicController.data.projectileDamage)

        self.scene?.addChild(projectile)

        projectile.physicsBody?.applyForce(force)
    }

    func contact(with colisionGroup: ColisionGroup, damage: CGFloat?) {
        if colisionGroup == .playerProjectile {
            pulseRed()
            let isDead = logicController.receiveDamage(damage ?? 0)
            
            if isDead { tearDown() }
        }
    }
}
