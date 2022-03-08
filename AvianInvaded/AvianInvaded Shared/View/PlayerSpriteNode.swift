//
//  PlayerSpriteNode.swift
//  AvianInvaded
//
//  Created by Marcos Chevis on 07/03/22.
//

import Foundation
import SpriteKit

class PlayerNode: SKNode {
    
//    var image: UIImage
    let playerLogic: PlayerLogic = PlayerLogic()
    
    let bodySprite: SKSpriteNode
    
    override init() {
        bodySprite = .init(imageNamed: "MainChar")
        bodySprite.setScale(0.03)

        super.init()
        self.addChildren()
    }
    
    func update(_ currentTime: TimeInterval) {
        playerLogic.position = self.position
    }
    
    func addChildren() {
        addChild(bodySprite)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func rotate(by angle: CGFloat) {
        let action = SKAction.rotate(toAngle: angle, duration: 0)
        self.run(action)
    }
    
    func move(by vector: CGVector) {
        print(self.position)
        self.position  = playerLogic.move(by: vector ,initialPosition: position)
        print(self.position)
    }
    
}

extension PlayerNode: PlayerLogicDelegate {
    func move(to: CGPoint) {
        self.position.x = position.x * 10
        self.position.y = position.y * 10
    }
    
    
}
