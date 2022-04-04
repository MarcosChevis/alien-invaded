//
//  EnemyFactory.swift
//  AvianInvaded
//
//  Created by Gabriel Ferreira de Carvalho on 21/03/22.
//

import Foundation
import CoreGraphics

protocol EnemyFactory {
    init(multiplier: Double)
    func build(at initialPosition: CGPoint,
               notificationCenter: NotificationCenter,
               delegate: EnemyDelegate?) -> Enemy
}
