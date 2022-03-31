//
//  PlayerLifeNode.swift
//  AvianInvaded
//
//  Created by Marcos Chevis on 24/03/22.
//

import Foundation
import SpriteKit

class PlayerHudNode: SKNode {

    var xpBar: SKShapeNode
    var emptyXpBar: SKShapeNode
    
    var lifeBar: SKShapeNode
    var lostLifeBar: SKShapeNode
    
    var upgradeLabel: SKLabelNode
    
    init(screenSize: CGSize, sceneSize: CGSize = CGSize(width: 1080, height: 810)) {
        
        let ratioHightByWidthScreen = screenSize.height/screenSize.width
        
        let ySize = sceneSize.width * ratioHightByWidthScreen
        let dif = (sceneSize.height - ySize)/2
        
        let rectLife = CGRect(origin: .zero, size: CGSize(width: sceneSize.width * 0.4,
                                                          height: sceneSize.height*0.05))
        
        let rectXp = CGRect(origin: .zero, size: CGSize(width: sceneSize.width * 0.7,
                                                        height: sceneSize.height*0.02))
        
        
        lifeBar = .init(rect: rectLife)
        lifeBar.fillColor = SKColor.red.withAlphaComponent(0.7)
        lifeBar.strokeColor = .clear
        
        lostLifeBar = .init(rect: rectLife)
        lostLifeBar.fillColor = SKColor.darkGray.withAlphaComponent(0.7)
        lostLifeBar.strokeColor = .clear
        
        
        
        emptyXpBar = .init(rect: rectXp, cornerRadius: sceneSize.height*0.01)
        emptyXpBar.fillColor = SKColor.gray.withAlphaComponent(0.7)
        emptyXpBar.strokeColor = .clear
        
        xpBar = .init(rect: rectXp, cornerRadius: sceneSize.height*0.01)
        xpBar.fillColor = SKColor.green.withAlphaComponent(0.7)
        xpBar.strokeColor = .clear
        
        upgradeLabel = .init(text: "")
        
        
        super.init()
        
        self.zPosition = 10
        
        lifeBar.position = CGPoint(x: -rectLife.width/2, y: +(dif + rectXp.height) - sceneSize.height/2)
        lostLifeBar.position = CGPoint(x: -rectLife.width/2, y: +(dif + rectXp.height) - sceneSize.height/2)
        
        
        xpBar.position = CGPoint(x: -rectXp.width*0.5, y: -(dif + rectXp.height + 5) + sceneSize.height/2)
        emptyXpBar.position = CGPoint(x: -rectXp.width*0.5 , y: -(dif + rectXp.height + 5) + sceneSize.height/2)
        
        upgradeLabel.position = CGPoint(x: 0, y: (ySize)*0.35)
        upgradeLabel.fontColor = SKColor.green
        upgradeLabel.fontName = "munro"
        upgradeLabel.color = .red
        
        upgradeLabel.run(SKAction.fadeOut(withDuration: 0))
        updateUpgradeLabel(upgrades: [.acceleration: 1])
        
        self.addChildren([lostLifeBar, lifeBar, emptyXpBar, xpBar, upgradeLabel])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addChildren(_ nodes: [SKNode]) {
        nodes.forEach { node in
            self.addChild(node)
        }
    }
    
    
}

extension PlayerHudNode: PlayerHudDelegate {
    func updateHealth(_ percentOfMaxHealth: CGFloat) {
        if percentOfMaxHealth >= 0 && percentOfMaxHealth <= 1 {
            lifeBar.run(SKAction.scaleX(to: percentOfMaxHealth, duration: 0.3))
        }
    }
    
    func updateExperience(_ percentOfMaxExperience: CGFloat) {
        if percentOfMaxExperience >= 0 && percentOfMaxExperience <= 1 {
            xpBar.run(SKAction.scaleX(to: percentOfMaxExperience, duration: 0.3))
        }
    }
    
    func updateUpgradeLabel(upgrades: [PlayerUpgrade:Float]) {
        var string: String = ""
        for upgrade in upgrades {
            var i: Float = 0
            while i < upgrade.value {
                string += "+"
                i += 0.5
            }
            string += " " + upgrade.key.rawValue
            string += "  "
        }
        
        upgradeLabel.text = string
        upgradeLabel.run(SKAction.fadeIn(withDuration: 1)) {
            self.upgradeLabel.run(SKAction.fadeOut(withDuration: 1))
        }
    }
    
}
