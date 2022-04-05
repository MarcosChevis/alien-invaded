//
//  PlayerLifeNode.swift
//  AvianInvaded
//
//  Created by Marcos Chevis on 24/03/22.
//

import Foundation
import SpriteKit

class PlayerHudNode: SKNode, ScoreUpdateDelegate {
    
    var xpIcon: SKSpriteNode
    var xpBar: SKShapeNode
    var emptyXpBar: SKShapeNode
    
    var lifeIcon: SKSpriteNode
    var lifeBar: SKShapeNode
    var lostLifeBar: SKShapeNode
    
    var upgradeLabel: SKLabelNode
    var scoreLabel: SKLabelNode
    
    private let screenSize: CGSize
        
    init(screenSize: CGSize,
         sceneSize: CGSize = CGSize(width: 1080, height: 810)) {
        
        let ratioHightByWidthScreen = screenSize.height/screenSize.width
        let ySize = sceneSize.width * ratioHightByWidthScreen
        let dif = (sceneSize.height - ySize)/2
        let rectLife = CGRect(origin: .zero, size: CGSize(width: sceneSize.width * 0.3,
                                                          height: sceneSize.height*0.03))
        let rectXp = CGRect(origin: .zero, size: CGSize(width: sceneSize.width * 0.3,
                                                        height: sceneSize.height*0.03))
        
        lifeIcon = .init(imageNamed: "PlusPixel")
        lifeIcon.scale(to: CGSize(width: rectLife.height - 4, height: rectLife.height - 4))
        
        xpIcon = .init(imageNamed: "ArrowPixel")
        xpIcon.scale(to: CGSize(width: rectXp.height - 4, height: rectXp.height - 4))
        
        lifeBar = .init(rect: rectLife)
        lifeBar.fillColor = SKColor.red.withAlphaComponent(0.7)
        lifeBar.strokeColor = .clear
        
        lostLifeBar = .init(rect: rectLife)
        lostLifeBar.fillColor = SKColor.darkGray.withAlphaComponent(0.7)
        lostLifeBar.strokeColor = .clear
        
        emptyXpBar = .init(rect: rectXp, cornerRadius: 0)
        emptyXpBar.fillColor = SKColor.gray.withAlphaComponent(0.7)
        emptyXpBar.strokeColor = .clear
        
        xpBar = .init(rect: rectXp, cornerRadius: 0)
        xpBar.fillColor = SKColor.init(red: 150, green: 150, blue: 0, alpha: 0.7)
        xpBar.strokeColor = .clear
        
        upgradeLabel = .init(text: "")
        scoreLabel = .init(text: "0")
        self.screenSize = screenSize
        
        super.init()
        self.zPosition = 16
        setupLabels(sceneSize: sceneSize, rectLife: rectLife)
        setPositions(dif: dif, rectXp: rectXp, sceneSize: sceneSize, ySize: ySize)
  
        upgradeLabel.run(SKAction.fadeOut(withDuration: 0))
        xpBar.run(SKAction.scaleX(to: 0, duration: 0))
        
        self.addChildren([lostLifeBar,
                          lifeBar,
                          emptyXpBar,
                          xpBar,
                          upgradeLabel,
                          scoreLabel,
                          lifeIcon,
                          xpIcon])
    }
    
    private func setupLabels(sceneSize: CGSize, rectLife: CGRect) {
        scoreLabel.preferredMaxLayoutWidth = sceneSize.width/2 - (rectLife.width)
        
        upgradeLabel.fontColor = SKColor.green
        upgradeLabel.fontName = "munro"
        upgradeLabel.color = .red
        
        scoreLabel.fontColor = SKColor.green
        scoreLabel.fontName = "munro"
        scoreLabel.color = .red
    }
    
    private func setPositions(dif: CGFloat, rectXp: CGRect, sceneSize: CGSize, ySize: CGFloat) {
        lifeBar.position = CGPoint(x: 0 + 20,
                                   y: -(dif + rectXp.height + 10) + sceneSize.height/2)
        
        lifeIcon.position = CGPoint(x: lifeBar.position.x + lifeIcon.size.width/2 + 10,
                                    y: lifeBar.position.y + lifeIcon.size.height/2 + 2)
        
        lostLifeBar.position = lifeBar.position
        
        xpBar.position = CGPoint(x: -rectXp.width - 20,
                                 y: -(dif + rectXp.height + 10) + sceneSize.height/2)
        
        xpIcon.position = CGPoint(x: xpBar.position.x + xpIcon.size.width/2 + 10,
                                  y: xpBar.position.y + xpIcon.size.height/2 + 2)
        
        emptyXpBar.position = xpBar.position
        
        upgradeLabel.position = CGPoint(x: 0, y: (ySize)*0.35)
        
        scoreLabel.position = CGPoint(x: lifeBar.position.x + rectXp.width +
                                      scoreLabel.preferredMaxLayoutWidth/2,
                                      y: lifeBar.position.y)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addChildren(_ nodes: [SKNode]) {
        nodes.forEach { node in
            self.addChild(node)
        }
    }

    func reset() {
        lifeBar.run(SKAction.resize(toWidth: screenSize.width * 0.4, duration: 0))
    }
}

extension PlayerHudNode: PlayerHudDelegate {
    func updateHealth(_ percentOfMaxHealth: CGFloat) {
        print("percentage: ", percentOfMaxHealth * 100)
        if percentOfMaxHealth >= 0 && percentOfMaxHealth <= 1 {
            lifeBar.run(SKAction.scaleX(to: percentOfMaxHealth, duration: 0.3))
        } else {
            lifeBar.run(SKAction.scaleX(to: 0, duration: 0.3))
        }
    }
    
    func updateExperience(_ percentOfMaxExperience: CGFloat) {
        if percentOfMaxExperience >= 0 && percentOfMaxExperience <= 1 {
            xpBar.run(SKAction.scaleX(to: percentOfMaxExperience, duration: 0.3))
        }
    }
    
    func updateUpgradeLabel(upgrades: [PlayerUpgrade: Float]) {
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
    
    func updateScoreLabel(score: Int) {
        self.scoreLabel.text = String(score)
    }
    
}
