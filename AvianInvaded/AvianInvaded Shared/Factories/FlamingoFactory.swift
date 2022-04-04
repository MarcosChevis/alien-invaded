//
//  FlamingoFactory.swift
//  AvianInvaded
//
//  Created by Marcos Chevis on 31/03/22.
//

import Foundation
import CoreGraphics

struct FlamingoFactory: EnemyFactory {
    private let multiplier: Double
    
    init(multiplier: Double) {
        self.multiplier = multiplier
    }
    
    func build(at initialPosition: CGPoint,
               notificationCenter: NotificationCenter,
               delegate: EnemyDelegate?) -> Enemy {
        
        let initialData = EnemyData(frictionMultiplier: 10,
                                    mass: 1,
                                    scale: 0.15,
                                    moveMultiplier: 500 * multiplier,
                                    facingAngle: 0,
                                    speedLimit: 700 * multiplier,
                                    projectileSize: 0.3,
                                    attackDistance: 150,
                                    distanceEnemyFromPlayer: 80,
                                    shootCadence: 0.8 * multiplier,
                                    shootingMagnitude: 2000 * multiplier,
                                    maxHealth: 10 * multiplier,
                                    currentHealth: 10 * multiplier,
                                    projectileDamage: 0.3 * multiplier)
        
        let flamingo = FlamingoNode(spawnAt: initialPosition,
                                  notificationCenter: notificationCenter,
                                  initialData: initialData)
        flamingo.delegate = delegate
        return flamingo
    }
}
