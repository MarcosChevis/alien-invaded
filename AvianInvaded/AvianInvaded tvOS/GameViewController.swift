//
//  GameViewController.swift
//  AvianInvaded tvOS
//
//  Created by Marcos Chevis on 03/03/22.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
       

        // Present the scene
        
    }
    override func loadView() {
        let scene = GameScene()
    
        let skView = SKView(frame: .zero)
        
        skView.presentScene(scene)
        
        skView.ignoresSiblingOrder = true
        skView.showsFPS = true
        skView.showsNodeCount = true
        
        self.view = skView
        
    }

}
