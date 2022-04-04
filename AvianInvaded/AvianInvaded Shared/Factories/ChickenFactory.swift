//
//  ChickenFactory.swift
//  AvianInvaded
//
//  Created by Gabriel Ferreira de Carvalho on 21/03/22.
//
import Foundation
import CoreGraphics

struct ChickenFactory: EnemyFactory {
    private let multiplier: Double
    
    init(multiplier: Double) {
        self.multiplier = multiplier
    }
    
    func build(at initialPosition: CGPoint,
               notificationCenter: NotificationCenter,
               delegate: EnemyDelegate?) -> Enemy {
        
        let initialData = EnemyData(frictionMultiplier: 10,
                                    mass: 1,
                                    scale: 0.1,
                                    moveMultiplier: 500 * multiplier,
                                    facingAngle: 0,
                                    speedLimit: 600 * multiplier,
                                    projectileSize: 0.3,
                                    attackDistance: 1000,
                                    distanceEnemyFromPlayer: 400,
                                    shootCadence: 0.8 * multiplier,
                                    shootingMagnitude: 2000 * multiplier,
                                    maxHealth: 10 * multiplier,
                                    currentHealth: 10 * multiplier,
                                    projectileDamage: 0.3 * multiplier)
        
        let chicken = ChickenNode(spawnAt: initialPosition,
                                  notificationCenter: notificationCenter,
                                  initialData: initialData)
        chicken.delegate = delegate
        return chicken
    }
}
