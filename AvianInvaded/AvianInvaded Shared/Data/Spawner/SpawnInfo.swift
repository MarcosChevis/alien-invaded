//
//  SpawnInfo.swift
//  AvianInvaded
//
//  Created by Gabriel Ferreira de Carvalho on 21/03/22.
//

import Foundation
import CoreGraphics

struct SpawnInfo {
    let availablePositions: [CGPoint]
    let tileSize: CGFloat
    let enemySpawns: [EnemySpawn]
}

struct EnemySpawn {
    let quantity: Int
    let factory: EnemyFactory
}
