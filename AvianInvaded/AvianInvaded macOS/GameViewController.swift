//
//  GameViewController.swift
//  AvianInvaded macOS
//
//  Created by Marcos Chevis on 03/03/22.
//

import AppKit
import SpriteKit
import GameplayKit

class GameViewController: NSViewController {
    
    
    
    override func loadView() {
        let scene = GameScene()
        
        // Present the scene
        let skView = SKView(frame: NSRect(x: 0, y: 0, width: NSScreen.main?.frame.width ?? 100, height: NSScreen.main?.frame.height ?? 100))
        skView.presentScene(scene)
        
        skView.ignoresSiblingOrder = true
        
        skView.showsFPS = true
        skView.showsNodeCount = true
        
        self.view = skView
    }
}

//class GameViewController: NSViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.wantsLayer = true
//        view.layer?.backgroundColor = NSColor.red.cgColor
//
//    }
    
    
//    override func loadView() {
//        let scene = GameScene()
//
//        // Present the scene
//        let skView = SKView(frame: .zero)
//        skView.presentScene(scene)
//
//        skView.ignoresSiblingOrder = true
//
//        skView.showsFPS = true
//        skView.showsNodeCount = true
//
//        self.view = skView
//    }

//}

