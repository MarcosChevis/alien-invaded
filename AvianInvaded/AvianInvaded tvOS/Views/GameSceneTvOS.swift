//
//  GameSceneTvOS.swift
//  AvianInvaded tvOS
//
//  Created by Marcos Chevis on 15/03/22.
import SpriteKit
//
//  GameScene.swift
//  AvianInvaded Shared
//
//  Created by Marcos Chevis on 03/03/22.
//

import SpriteKit
import GameplayKit

class GameSceneTvOS: SKScene {
    
    let playerNode: PlayerNode
    private let gameCamera = SKCameraNode()
    var gameLogicController: GameLogicController
    
    init(gameLogicController: GameLogicController, inputController: InputControllerProtocol, size: CGSize) {
        self.gameLogicController = gameLogicController
        self.playerNode = PlayerNode(inputController: inputController)
        
        super.init(size: size)
        
        self.scaleMode = .aspectFill
        let initialRoom = gameLogicController.buildNewRoom()
        self.camera = gameCamera
        self.addChildren([initialRoom, self.playerNode])
        self.moveNodeToCenter(playerNode, size: size)
        self.physicsWorld.contactDelegate = self
        
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
        gameLogicController
            .spawnEnemies()
            .forEach { enemy in
                addChild(enemy)
            }
        
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
    
    override func didSimulatePhysics() {
        camera?.position = playerNode.position
        children
            .compactMap { $0 as? LifeCycleElement }
            .forEach { $0.didSimulatePhysics() }
    }
    
}

extension GameSceneTvOS: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        if
            let contactableNodeA = contact.bodyA.node as? Contactable,
            let colisionGroup = contact.bodyB.node?.colisionGroup {
            contactableNodeA.contact(with: colisionGroup)
        }
        
        if
            let contactableNodeB = contact.bodyB.node as? Contactable,
            let colisionGroup = contact.bodyA.node?.colisionGroup {
            contactableNodeB.contact(with: colisionGroup)
        }
    }
}
