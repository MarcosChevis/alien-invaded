//
//  GameLogicDelegate.swift
//  AvianInvaded
//
//  Created by Marcos Chevis on 07/03/22.
//

import Foundation
import SpriteKit

protocol GameLogicDelegate: AnyObject {
    func teleport(to newRoom: SKNode)
    func enemyKilled()
    func gameOver()
    func restart()
}
