//
//  Enemy.swift
//  AvianInvaded
//
//  Created by Gabriel Ferreira de Carvalho on 18/03/22.
//

import Foundation
import SpriteKit

protocol Enemy: SKNode, LifeCycleElement, Contactable {
    init(spawnAt initialPosition: CGPoint, notificationCenter: NotificationCenter)
    
    func move(path: [CGPoint], tileSize: CGFloat)
}
