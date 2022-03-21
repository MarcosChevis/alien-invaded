//
//  SpawnerLogicController.swift
//  AvianInvaded
//
//  Created by Gabriel Ferreira de Carvalho on 21/03/22.
//

import Foundation
import SpriteKit

final class Spawner {
    
    func spawn(for info: SpawnInfo) -> [Enemy] {
        var positions = info.availablePositions.shuffled()
        
        let enemies = info
            .enemySpawns
            .flatMap { enemyInfo -> [Enemy] in
                Array(repeating: 0, count: enemyInfo.quantity)
                    .compactMap { _ in
                        guard let position = positions.popLast() else { return nil }
                        return buildEnemy(enemyInfo: enemyInfo,
                                          position: position,
                                          tileSize: info.tileSize)
                    }
            }
        
        return enemies
    }
    
    private func buildEnemy(enemyInfo: EnemySpawn, position: CGPoint, tileSize: CGFloat) -> Enemy {
        enemyInfo.factory.build(at: CGPoint(x: position.x * tileSize,
                                            y: position.y * tileSize),
                                notificationCenter: .default)
    }
}
