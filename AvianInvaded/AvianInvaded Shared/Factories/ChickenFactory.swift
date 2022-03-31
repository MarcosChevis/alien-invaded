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
    
    func build(at initialPosition: CGPoint,
               notificationCenter: NotificationCenter,
               delegate: EnemyDelegate?) -> Enemy {
        
        let chicken = ChickenNode(spawnAt: initialPosition, notificationCenter: notificationCenter)
        chicken.delegate = delegate
        return chicken
    }
}
