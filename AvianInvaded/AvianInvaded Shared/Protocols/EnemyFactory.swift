//
//  EnemyFactory.swift
//  AvianInvaded
//
//  Created by Gabriel Ferreira de Carvalho on 21/03/22.
//

import Foundation
import CoreGraphics

protocol EnemyFactory {
    func build(at initialPosition: CGPoint, notificationCenter: NotificationCenter) -> Enemy
}

extension EnemyFactory {
    static var availableFactories: [EnemyFactory] {
        [ChickenFactory()]
    }
}
