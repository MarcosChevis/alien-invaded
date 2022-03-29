//
//  GameScene.swift
//  AvianInvaded Shared
//
//  Created by Marcos Chevis on 03/03/22.
//

import SpriteKit
import GameplayKit

class GameSceneIOS: SKScene {
    
    let playerNode: PlayerNode
    let playerHudNode: PlayerHudNode
    private let gameCamera = SKCameraNode()
    var gameLogicController: GameLogicController
    
    init(gameLogicController: GameLogicController, inputController: InputControllerProtocol, size: CGSize) {
        self.gameLogicController = gameLogicController
        
        self.playerHudNode = .init(sceneSize: size)
        self.playerNode = PlayerNode(inputController: inputController, hudDelegate: playerHudNode)
        
        super.init(size: size)
        
        self.scaleMode = .aspectFill
        self.camera = gameCamera
        self.addChildren([self.playerNode, playerHudNode])
        gameLogicController.gameLogicDelegate = self
        self.physicsWorld.contactDelegate = self
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.black
        self.setupScene()
    }
    
    func setupScene() {
        children
            .compactMap { $0 as? LifeCycleElement }
            .forEach { $0.startup() }
        
        let initialRoom = gameLogicController.buildNewRoom()
        setupRoom(initialRoom)
    }
    
    private func setupRoom(_ room: SKNode) {
        let move = SKAction.move(to: gameLogicController.getplayerStartPosition(forScreen: self.size),
                                  duration: .zero)
        playerNode.run(move)
        addChild(room)
        
        let enemies = gameLogicController.spawnEnemies()
        
        addChildren(enemies)
        
        enemies
            .compactMap { $0 as? LifeCycleElement }
            .forEach { $0.startup() }
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        gameLogicController.update(currentTime)
        
        children
            .compactMap { $0 as? LifeCycleElement }
            .forEach { $0.update(currentTime) }
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
        playerHudNode.position = playerNode.position
        
        children
            .compactMap { $0 as? LifeCycleElement }
            .forEach { $0.didSimulatePhysics() }
    }
}

extension GameSceneIOS: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        
        guard let colisionGroupA = contact.bodyA.node?.colisionGroup,
              let colisionGroupB = contact.bodyB.node?.colisionGroup else { return }
        
        let aDamage = (contact.bodyA.node as? Contactable)?.damage
        let bDamage = (contact.bodyB.node as? Contactable)?.damage
               
        if let contactableNodeA = contact.bodyA.node as? Contactable {
            contactableNodeA.contact(with: colisionGroupB, damage: bDamage)
        }
        
        if let contactableNodeB = contact.bodyB.node as? Contactable {
            contactableNodeB.contact(with: colisionGroupA, damage: aDamage)
        }
    }
}

extension GameSceneIOS: GameLogicDelegate {
    func teleport(to newRoom: SKNode) {
        children.forEach { node in
            if node.colisionGroup != .player {
                node.removeFromParent()
            }
        }
       setupRoom(newRoom)
    }
}


