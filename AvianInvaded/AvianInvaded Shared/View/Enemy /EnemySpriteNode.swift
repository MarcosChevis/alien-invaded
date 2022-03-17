//
//  EnemySpriteNode.swift
//  AvianInvaded
//
//  Created by thais on 11/03/22.
//

import Foundation
import SpriteKit

class EnemyNode: SKNode, LifeCycleElement {
    
    private let logicController: EnemyLogicController = EnemyLogicController()
    private let bodySprite: SKSpriteNode
    var projectileTexture: SKTexture
    
    override init() {
        bodySprite = .init(imageNamed: "Chicken")
       
        #warning("mudar para a escala global")
        let projectileImage = UIImage(named: "Chicken")
        self.projectileTexture = .init(image: projectileImage ?? .init())
       
        super.init()
        self.colisionGroup = .enemy

        addChild(bodySprite)
        
        bodySprite.setScale(0.01)
    }
    
    func uptade(_ currentTime: TimeInterval) {
        
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
        
        self.parent?.addChild(projectile)
        
        projectile.physicsBody?.applyForce(force)
    }
    
    private func scale() {
        let size = self.bodySprite.scaleToScreen(scale: logicController.scale)
        bodySprite.size = size
    }
    
}
