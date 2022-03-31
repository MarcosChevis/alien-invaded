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
        
        let initialData = EnemyData(frictionMultiplier: 10,
                                    mass: 1,
                                    scale: 0.1,
                                    moveMultiplier: 500,
                                    facingAngle: 0,
                                    speedLimit: 600,
                                    projectileSize: 0.3,
                                    attackDistance: 1000,
                                    distanceEnemyFromPlayer: 400,
                                    shootCadence: 0.8,
                                    shootingMagnitude: 2000,
                                    maxHealth: 10,
                                    currentHealth: 10,
                                    projectileDamage: 0.3)
        
        let chicken = ChickenNode(spawnAt: initialPosition,
                                  notificationCenter: notificationCenter,
                                  initialData: initialData)
        chicken.delegate = delegate
        return chicken
    }
}
