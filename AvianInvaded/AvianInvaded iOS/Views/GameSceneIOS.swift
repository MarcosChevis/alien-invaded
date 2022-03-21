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
    private let gameCamera = SKCameraNode()
    var gameLogicController: GameLogicController
    
    #warning("TESTE")
    var graph: GKGridGraph<GKGridGraphNode>
    var solution: [CGPoint]? = nil
    var enemy: Enemy? = nil
    var tileSize: CGFloat = 0
    var room: SKNode? = nil
    
    init(gameLogicController: GameLogicController, inputController: InputControllerProtocol, size: CGSize) {
        self.gameLogicController = gameLogicController

        self.playerNode = PlayerNode(inputController: inputController)
        graph = .init(fromGridStartingAt: .init(x: 0, y: 0),
                      width: Int32(Room.test.tiles[0].count),
                      height: Int32(Room.test.tiles.count),
                      diagonalsAllowed: true)
        
        
        super.init(size: size)
        
        #warning("TESTE")
        let builder = RoomBuilder(sceneSize: self.size)
        self.room = builder.build(room: .test)
        let enemyPosition = (room!.children[0] as! SKSpriteNode).size.width*10
        let enemyNode: Enemy = ChickenNode(spawnAt: .init(x: enemyPosition, y: enemyPosition), notificationCenter: .default)
        self.enemy = enemyNode
        self.camera = gameCamera
        self.addChildren([room!, self.playerNode, enemyNode])
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
    
    func addChildren(_ nodes: [SKNode]) {
        for node in nodes {
            self.addChild(node)
        }
    }
    override func didChangeSize(_ oldSize: CGSize) {
        GameConstants.updateForceMultiplaier(screenSize: self.size)
    }
    
    func moveNodeToCenter(_ node: SKNode, size: CGSize) {
        node.position.x = size.width/2
        node.position.y = size.height/2
    }
    
    override func didSimulatePhysics() {
        camera?.position = playerNode.position
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let startPosition: CGPoint = .init(x: Int(enemy!.position.x / (room!.children[0] as! SKSpriteNode).size.width) , y: Int(enemy!.position.y / (room!.children[0] as! SKSpriteNode).size.width))
        let endPosition: CGPoint = .init(x: Int(playerNode.position.x / (room!.children[0] as! SKSpriteNode).size.width) , y: Int(playerNode.position.y / (room!.children[0] as! SKSpriteNode).size.width))
        
        let solution = graph.findPath(from:
                                        graph.node(atGridPosition: .init(x: Int32(startPosition.x),
                                                                         y: Int32(startPosition.y)))!,
                                      to: graph.node(atGridPosition: .init(x: Int32(endPosition.x),
                                                                           y: Int32(endPosition.y)))!
        ) as! [GKGridGraphNode]
        print(solution.map(\.gridPosition))
        
        self.solution = solution.map { CGPoint(x: Int($0.gridPosition.x), y: Int($0.gridPosition.y)) }
        self.tileSize = (room!.children[0] as! SKSpriteNode).size.width
        
        enemy?.move(path: self.solution!, tileSize: tileSize)
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


