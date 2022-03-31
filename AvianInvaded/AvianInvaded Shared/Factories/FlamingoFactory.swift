//
//  FlamingoFactory.swift
//  AvianInvaded
//
//  Created by Marcos Chevis on 31/03/22.
//

import Foundation
import CoreGraphics

class FlamingoFactory: EnemyFactory {
    private var cachedEnemy: FlamingoNode?
    
    func build(at initialPosition: CGPoint,
               notificationCenter: NotificationCenter,
               delegate: EnemyDelegate?) -> Enemy {
        
        let initialData = EnemyData(frictionMultiplier: 10,
                                    mass: 1,
                                    scale: 0.15,
                                    moveMultiplier: 500,
                                    facingAngle: 0,
                                    speedLimit: 700,
                                    projectileSize: 0.3,
                                    attackDistance: 150,
                                    distanceEnemyFromPlayer: 80,
                                    shootCadence: 0.8,
                                    shootingMagnitude: 2000,
                                    maxHealth: 10,
                                    currentHealth: 10,
                                    projectileDamage: 0.3)
        
        let flamingo = FlamingoNode(spawnAt: initialPosition,
                                  notificationCenter: notificationCenter,
                                  initialData: initialData)
        flamingo.delegate = delegate
        return flamingo
    }
}
