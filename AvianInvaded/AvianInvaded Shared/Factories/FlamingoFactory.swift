//
//  FlamingoFactory.swift
//  AvianInvaded
//
//  Created by Thais Bras on 29/03/22.
//

import Foundation
import CoreGraphics

class FlamingoFactory: EnemyFactory {
    
    func build(at initialPosition: CGPoint, notificationCenter: NotificationCenter, delegate: EnemyDelegate?) -> Enemy {
        let flamingo = FlamingoNode(spawnAt: initialPosition, notificationCenter: notificationCenter)
        flamingo.delegate = delegate
        return flamingo
    }
}
