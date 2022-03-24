//
//  Portal.swift
//  AvianInvaded iOS
//
//  Created by Gabriel Ferreira de Carvalho on 23/03/22.
//

import SpriteKit

final class Portal: SKNode {
    private let sprite: SKSpriteNode
    private let direction: RoomDirection
    private var alreadyUsed: Bool
    
    init(direction: RoomDirection, spriteSize: CGSize) {
        let texture = SKTexture(imageNamed: "Portal")
        self.sprite = SKSpriteNode(texture: texture, color: .clear, size: spriteSize)
        self.alreadyUsed = false
        self.direction = direction
        super.init()
        
        addChild(sprite)
        sprite.position = CGPoint(x: sprite.position.x - spriteSize.width/2,
                                  y: sprite.position.y - spriteSize.height/2)
        physicsBody = SKPhysicsBody(rectangleOf: spriteSize, center: sprite.position)
        physicsBody?.affectedByGravity = false
        physicsBody?.isDynamic = false
        colisionGroup = .portal
        physicsBody?.contactTestBitMask = ColisionGroup.getContactMask(colisionGroup)
        physicsBody?.collisionBitMask = ColisionGroup.getCollisionMask(colisionGroup)
        physicsBody?.categoryBitMask = ColisionGroup.getCategotyMask(colisionGroup)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension Portal: Contactable {
    func contact(with colisionGroup: ColisionGroup) {
        if !alreadyUsed {
            NotificationCenter.default.post(name: .init(rawValue: "teste.portal"), object: direction)
            alreadyUsed = true
        }
    }
}
