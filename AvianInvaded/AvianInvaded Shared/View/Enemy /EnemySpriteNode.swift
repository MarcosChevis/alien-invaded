//
//  EnemySpriteNode.swift
//  AvianInvaded
//
//  Created by thais on 11/03/22.
//

import Foundation
import SpriteKit

class EnemyNode: SKNode {
    
    private let logicController: EnemyLogicController = EnemyLogicController()
    private let bodySprite: SKSpriteNode
    //var projectileTexture: SKTexture
    
    override init() {
        bodySprite = .init(imageNamed: "Chicken")
        bodySprite.setScale(logicController.scale)
       
        super.init()
        addChild(bodySprite)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
