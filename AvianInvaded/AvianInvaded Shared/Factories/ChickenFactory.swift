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
        if let cachedEnemy = cachedEnemy {
            return cachedEnemy
        }
        
        let chickenEnemy = ChickenNode(spawnAt: initialPosition, notificationCenter: notificationCenter)
        cachedEnemy = chickenEnemy
        return chickenEnemy
    }
}
