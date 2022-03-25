//
//  GameViewController.swift
//  AvianInvaded iOS
//
//  Created by Marcos Chevis on 03/03/22.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewControllerTvOS: UIViewController {
    
    let gameScene: GameSceneTvOS
    
    init(gameLogicController: GameLogicController, size: CGSize) {
        self.gameScene = GameSceneTvOS(gameLogicController: gameLogicController, inputController: InputControllerTvOS(), size: size)
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Present the scene
        
    }
    override func loadView() {
        let scene = gameScene
    
        let skView = SKView(frame: .zero)
        
        skView.presentScene(scene)
//        skView.showsPhysics = true
        
        skView.ignoresSiblingOrder = true
        skView.showsFPS = true
        skView.showsNodeCount = true
        scene.scaleMode = .aspectFill
        
        self.view = skView
        
    }
}
