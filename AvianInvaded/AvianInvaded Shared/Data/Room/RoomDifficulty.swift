//
//  RoomDifficulty.swift
//  AvianInvaded
//
//  Created by Gabriel Ferreira de Carvalho on 22/03/22.
//

import Foundation

struct RoomDifficulty {
    let damageMultiplier: Double
    let speedMultiplier: Double
    let lifeMultiplier: Double
    let spawnMultiplier: Double
}

extension RoomDifficulty {
    static var standard: Self {
        .init(damageMultiplier: 1,
              speedMultiplier: 1,
              lifeMultiplier: 1,
              spawnMultiplier: 1)
    }
}
