//
//  ChickenFactory.swift
//  AvianInvaded
//
//  Created by Gabriel Ferreira de Carvalho on 21/03/22.
//
import Foundation
import CoreGraphics

class ChickenFactory: EnemyFactory {
    private var cachedEnemy: ChickenNode?
    
    func build(at initialPosition: CGPoint, notificationCenter: NotificationCenter) -> Enemy {
        ChickenNode(spawnAt: initialPosition, notificationCenter: notificationCenter)
    }
}
