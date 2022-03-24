//
//  GameScene.swift
//  AvianInvaded Shared
//
//  Created by Marcos Chevis on 03/03/22.
//

import SpriteKit
import GameplayKit
import Combine

class GameSceneIOS: SKScene {
    
    let playerNode: PlayerNode
    private let gameCamera = SKCameraNode()
    private var cancellables = Set<AnyCancellable>()
    var gameLogicController: GameLogicController
    
    init(gameLogicController: GameLogicController, inputController: InputControllerProtocol, size: CGSize) {
        self.gameLogicController = gameLogicController
        self.playerNode = PlayerNode(inputController: inputController)
        
        super.init(size: size)
        self.scaleMode = .aspectFill
        self.camera = gameCamera
        self.addChildren([self.playerNode])
        self.physicsWorld.contactDelegate = self
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupBindings() {
        NotificationCenter
            .default
            .publisher(for: .init(rawValue: "teste.portal"))
            .compactMap { $0.object as? RoomDirection}
            .sink(receiveValue: teleport)
            .store(in: &cancellables)
    }
    
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.black
        self.setupScene()
    }
    
    func setupScene() {
        setupBindings()
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
        children
            .compactMap { $0 as? LifeCycleElement }
            .forEach { $0.didSimulatePhysics() }
    }
    
    private func teleport(direction: RoomDirection) {
        let newRoom = gameLogicController.nextRoom(direction: direction)
        children.forEach { node in
            if node.colisionGroup != .player {
                node.removeFromParent()
            }
        }
       setupRoom(newRoom)
    }
    
}

extension GameSceneIOS: SKPhysicsContactDelegate {
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


