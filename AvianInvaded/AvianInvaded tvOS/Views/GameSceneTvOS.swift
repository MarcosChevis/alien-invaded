//
//  GameSceneTvOS.swift
//  AvianInvaded tvOS
//
//  Created by Marcos Chevis on 15/03/22.
import SpriteKit

class GameSceneTvOS: SKScene {
    
    let playerNode: PlayerNode
    private let gameCamera = SKCameraNode()
    var gameLogicController: GameLogicController
    
    init(gameLogicController: GameLogicController, size: CGSize) {
        self.gameLogicController = gameLogicController
        self.playerNode = PlayerNode()
        
        super.init(size: size)
        let builder = RoomBuilder(sceneSize: self.size)
        let room = builder.build(room: .test)
        self.gameLogicController.gameLogicDelegate = self
        self.camera = gameCamera
        self.addChildren([room, self.playerNode])
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
        children
            .compactMap { $0 as? LifeCycleElement }
            .forEach { $0.startup() }
        
    }
    override func didChangeSize(_ oldSize: CGSize) {
        GameConstants.updateForceMultiplaier(screenSize: self.size)
        print(GameConstants.forceMultiplier)
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
    }
}


extension GameSceneTvOS: GameLogicDelegate {
    
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

extension GameSceneTvOS: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        if
            let contactableNodeA = contact.bodyA.node as? Contactable,
            let nodeB = contact.bodyB.node {
            contactableNodeA.contact(with: nodeB)
        }
        
        if
            let contactableNodeB = contact.bodyB.node as? Contactable,
            let nodeA = contact.bodyA.node {
            contactableNodeB.contact(with: nodeA)
        }
    }
}

protocol Contactable {
    func contact(with node: SKNode)
}
