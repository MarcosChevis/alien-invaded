//
//  GameScene.swift
//  AvianInvaded Shared
//
//  Created by Marcos Chevis on 03/03/22.
//

import SpriteKit

class GameScene: SKScene {
    
//    var joystickController: InputControllerProtocol = InputController()
    
    let gameLogicController: GameLogicController
    let playerNode: PlayerNode
    
    init(gameLogicController: GameLogicController, size: CGSize) {
        self.gameLogicController = gameLogicController
        self.playerNode = PlayerNode()
        
        super.init(size: size)
        
        self.gameController.gameLogicDelegate = self
        self.addChildren([self.playerNode])
        self.moveNodeToCenter(playerNode, size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.red
        self.setupScene()
    }
    
    #if os(iOS)
    var gameController: GameLogicController =  {
        let y = InputControllerIOS()
        let x = GameLogicController(inputController: y)
        
        y.inputDelegate = x
        
        return x
    }()
    
    override func update(_ currentTime: TimeInterval) {
        gameController.update(currentTime)
        playerNode.update(currentTime)
    }
    #endif
    
    func setupScene() {
//        joystickController.inputDelegate = self
        
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


extension GameScene: GameLogicDelegate {
    func movePlayer(with vector: CGVector) {
//        self.playerNode.position = position
        playerNode.move(by: vector)
    }
    
    func rotatePlayerTo(angle: CGFloat) {
        playerNode.rotate(by: angle)
    }
}
