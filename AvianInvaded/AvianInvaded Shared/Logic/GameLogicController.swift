//
//  GameLogicController.swift
//  AvianInvaded
//
//  Created by Marcos Chevis on 04/03/22.
//

import Foundation
import CoreGraphics
import SpriteKit

class GameLogicController {
    
    private var inputController: InputControllerProtocol
    weak var gameLogicDelegate: GameLogicDelegate?
    
    
    
    init(inputController: InputControllerProtocol) {
        self.inputController = inputController
    }
    
    func update() {
        inputController.update()
    }
    
}

extension GameLogicController: InputDelegate {
    
    func didChangeInputType(to inputType: InputType?) {
        guard let inputType = inputType else {
            print("no input connected")
            return
        }
        switch inputType {
        case .controller:
            print("controller connected")
        case .keyboard:
            print("keyboard connected")
        }
        
    }
    
    func updateMovement(vector: CGVector) {
//        print("to \(vector)")
//        gameLogicDelegate?.movePlayerTo(position: <#T##CGPoint#>)
        gameLogicDelegate?.movePlayer(with: vector)
    }
    
    func updateShooting(direction angle: CGFloat, isShooting: Bool) {
//        print("shooting at \(angle)")
        gameLogicDelegate?.rotatePlayerTo(angle: angle - (CGFloat.pi/2))
    }
    
    
}
