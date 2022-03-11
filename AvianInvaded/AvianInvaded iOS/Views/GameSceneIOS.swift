//
//  GameScene.swift
//  AvianInvaded Shared
//
//  Created by Marcos Chevis on 03/03/22.
//

import SpriteKit

class GameSceneIOS: SKScene {
    
    let playerNode: PlayerNode
    var gameLogicController: GameLogicController
    
    init(gameLogicController: GameLogicController, size: CGSize) {
        self.gameLogicController = gameLogicController
        self.playerNode = PlayerNode()
        
        super.init(size: size)
        
        self.gameLogicController.gameLogicDelegate = self
        
        self.addChildren([self.playerNode])
        self.moveNodeToCenter(playerNode, size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.black
        self.setupScene()
    }
    
    override func update(_ currentTime: TimeInterval) {
        gameLogicController.update(currentTime)
        
        children
            .compactMap { $0 as? LifeCycleElement }
            .forEach { $0.update(currentTime) }
    }
    
    
    func setupScene() {
        children
            .compactMap { $0 as? LifeCycleElement }
            .forEach { $0.startup() }
        
    }
    
    func addChildren(_ nodes: [SKNode]) {
        for node in nodes {
            self.addChild(node)
        }
    }
    
    func moveNodeToCenter(_ node: SKNode, size: CGSize) {
        node.position.x = size.width/2
        node.position.y = size.height/2
    }
}


extension GameSceneIOS: GameLogicDelegate {
    
    func movePlayer(with vector: CGVector) {
        playerNode.apply(force: vector)
    }
    
    func rotatePlayerTo(angle: CGFloat) {
        playerNode.rotate(by: angle)
    }
    
    func shoot(_ currentTime: TimeInterval) {
        playerNode.shoot(currentTime)
    }
}
