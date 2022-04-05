//
//  GameViewController.swift
//  AvianInvaded iOS
//
//  Created by Marcos Chevis on 03/03/22.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    let gameScene: GameScene
    
    init(gameLogicController: GameLogicController, sceneSize: CGSize) {
        self.gameScene = GameScene(gameLogicController: gameLogicController,
                                      inputController: InputControllerIOS(),
                                      sceneSize: sceneSize,
                                      screenSize: UIScreen.main.bounds.size)
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
        skView.showsPhysics = false
        
        skView.ignoresSiblingOrder = true
        skView.showsFPS = true
        skView.showsNodeCount = true
        scene.scaleMode = .aspectFill
        
        self.view = skView
        
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var preferredScreenEdgesDeferringSystemGestures: UIRectEdge {
        return .bottom
    }
}
