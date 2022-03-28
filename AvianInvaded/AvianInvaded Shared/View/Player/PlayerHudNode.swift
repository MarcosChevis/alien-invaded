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
    
    init(sceneSize: CGSize) {
        
        lifeBar = .init(rectOf: CGSize(width: sceneSize.width*0.4,
                                       height: sceneSize.height*0.05))
        lifeBar.fillColor = SKColor.red.withAlphaComponent(0.7)
        lifeBar.strokeColor = .clear
        
        lostLifeBar = .init(rectOf: CGSize(width: sceneSize.width*0.4,
                                           height: sceneSize.height*0.05))
        lostLifeBar.fillColor = SKColor.darkGray.withAlphaComponent(0.7)
        lostLifeBar.strokeColor = .clear
        
        let rect = CGRect(x: -(sceneSize.width*0.90)/2,
                          y: -sceneSize.height*0.01,
                          width: sceneSize.width*0.90,
                          height: sceneSize.height*0.01)
        
        emptyXpBar = .init(rect: rect,
                           cornerRadius: sceneSize.height*0.01)
        emptyXpBar.fillColor = SKColor.gray.withAlphaComponent(0.7)
        emptyXpBar.strokeColor = .clear
        
        xpBar = .init(rect: rect,
                      cornerRadius: sceneSize.height*0.01)
        xpBar.fillColor = SKColor.green.withAlphaComponent(0.7)
        xpBar.strokeColor = .clear
        
        upgradeLabel = .init(text: "")
        
        
        super.init()
        
        lifeBar.position = CGPoint(x: 0, y: -(sceneSize.height)*0.25)
        lostLifeBar.position = CGPoint(x: 0, y: -(sceneSize.height)*0.25)
        
        xpBar.position = CGPoint(x: 0, y: (sceneSize.height)*0.30)
        emptyXpBar.position = CGPoint(x: 0, y: (sceneSize.height)*0.30)
        
        xpBar.run(SKAction.scaleX(to: 0, duration: 0))
        
        upgradeLabel.position = CGPoint(x: 0, y: (sceneSize.height)*0.25)
        upgradeLabel.fontColor = SKColor.green
        upgradeLabel.fontName = "munro"
        upgradeLabel.color = .red
        
        upgradeLabel.run(SKAction.fadeOut(withDuration: 0))
        
        
        updateUpgradeLabel(upgrades: [.maxHealth:2, .acceleration:1])
        
        self.zPosition = 11
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
                i += 1
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
