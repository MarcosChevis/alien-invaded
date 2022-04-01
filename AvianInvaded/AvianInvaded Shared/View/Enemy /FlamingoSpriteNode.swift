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
    private let attackNode: FlamingoAttackNode
    var attackIsActive: Bool {
        didSet {
            if attackIsActive {
                attackNode.damage = attackDamage
            } else {
                attackNode.damage = nil
            }
        }
    }
    
    lazy var attackDamage = logicController.data.projectileDamage
    
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
        self.attackNode = .init(damage: logicController.data.projectileDamage)

        super.init()
        logicController.delegate = self
        self.colisionGroup = .enemy
        position = initialPosition
        zPosition = 2
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
        delegate?.enemyWasDefeatead()
        removeFromParent()
    }

    private func addChildren() {
        addChild(bodySprite)
        addChild(attackNode)
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
        attackNode.position = .zero
        self.attackNode.physicsBody = createAttackPhysicsBody(size: size)
        
        bodySprite.size = size
        
    }

    func attack(_ currentTime: TimeInterval) {
        
        guard logicController.decideAtack(currentTime: currentTime,
                                          position: self.position) != nil else { return }
        
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
    
    private func createAttackPath() -> CGPath {
        let path = CGMutablePath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: 70, y: 50))
        path.addLine(to: CGPoint(x: 75, y: 75))
        path.addLine(to: CGPoint(x: 0, y: 100))
        path.addLine(to: CGPoint(x: -75, y: 75))
        path.addLine(to: CGPoint(x: -70, y: 50))
        path.addLine(to: CGPoint(x: 0, y: 0))
        return path
    }
    
    private func createAttackPhysicsBody(size: CGSize) -> SKPhysicsBody {

        let phB: SKPhysicsBody = .init(polygonFrom: createAttackPath())
        phB.mass = 0.01
        phB.affectedByGravity = false
        phB.allowsRotation = false
        phB.isDynamic = true
        phB.pinned = true
           
        phB.contactTestBitMask = ColisionGroup.getContactMask(.enemyProjectile)
        phB.collisionBitMask = ColisionGroup.getCollisionMask(.enemyProjectile)
        phB.categoryBitMask = ColisionGroup.getCategotyMask(.enemyProjectile)
        
        return phB
    }

    func contact(with colisionGroup: ColisionGroup, damage: CGFloat?) {
        if colisionGroup == .playerProjectile {
            pulseRed()
            let isDead = logicController.receiveDamage(damage ?? 0)
            
            if isDead { tearDown() }
        }
    }
}
